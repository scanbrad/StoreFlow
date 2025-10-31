//
//  MyTasksView.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  MyTasksView.swift
//  StoreFlow
//
//  Main view for My Tasks feature
//

import SwiftUI

struct MyTasksView: View {
    @StateObject private var viewModel = MyTasksViewModel()
    @State private var selectedFilter: TaskFilter = .all
    @State private var selectedSort: TaskSort = .priority
    @State private var showingSortOptions = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Filter Picker
                filterPicker
                
                // Task List
                if viewModel.filteredTasks.isEmpty {
                    emptyState
                } else {
                    taskList
                }
            }
            .navigationTitle("My Tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    sortButton
                }
            }
            .confirmationDialog("Sort By", isPresented: $showingSortOptions) {
                ForEach(TaskSort.allCases, id: \.self) { sort in
                    Button(sort.displayName) {
                        selectedSort = sort
                        viewModel.sortTasks(by: sort)
                    }
                }
            }
            .onAppear {
                viewModel.loadTasks()
            }
        }
    }
    
    // MARK: - Filter Picker
    private var filterPicker: some View {
        Picker("Filter", selection: $selectedFilter) {
            ForEach(TaskFilter.allCases, id: \.self) { filter in
                Text(filter.displayName).tag(filter)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .onChange(of: selectedFilter) { newFilter in
            viewModel.filterTasks(by: newFilter)
        }
    }
    
    // MARK: - Task List
    private var taskList: some View {
        List {
            ForEach(viewModel.groupedTasks.keys.sorted(by: { $0.sortOrder < $1.sortOrder }), id: \.self) { status in
                if let tasks = viewModel.groupedTasks[status], !tasks.isEmpty {
                    Section(header: Text(status.displayName)) {
                        ForEach(tasks) { task in
                            NavigationLink(destination: TaskDetailView(task: task, viewModel: viewModel)) {
                                TaskRowView(task: task)
                            }
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
    }
    
    // MARK: - Empty State
    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle")
                .font(.system(size: 64))
                .foregroundColor(.secondary)
            
            Text("No Tasks")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(emptyStateMessage)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
    
    private var emptyStateMessage: String {
        switch selectedFilter {
        case .all:
            return "You have no tasks assigned"
        case .notStarted:
            return "No tasks waiting to be started"
        case .inProgress:
            return "No tasks currently in progress"
        case .complete:
            return "No completed tasks"
        }
    }
    
    // MARK: - Sort Button
    private var sortButton: some View {
        Button(action: {
            showingSortOptions = true
        }) {
            Image(systemName: "arrow.up.arrow.down")
                .font(.body)
        }
    }
}

// MARK: - Task Row View
struct TaskRowView: View {
    let task: Task
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Priority Indicator
            priorityIndicator
            
            // Task Content
            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.headline)
                    .foregroundColor(task.status == .complete ? .secondary : .primary)
                
                if let description = task.description {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                // Metadata Row
                HStack(spacing: 12) {
                    // Due Time
                    if let dueTime = task.formattedDueTime {
                        Label(dueTime, systemImage: "clock")
                            .font(.caption)
                            .foregroundColor(task.isOverdue ? .red : .secondary)
                    }
                    
                    // Related Feature
                    if let feature = task.relatedFeature {
                        Label(feature.displayName, systemImage: feature.iconName)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 4)
            }
            
            Spacer()
            
            // Status Badge
            if task.status == .complete {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
                    .font(.title3)
            }
        }
        .padding(.vertical, 4)
    }
    
    private var priorityIndicator: some View {
        RoundedRectangle(cornerRadius: 2)
            .fill(priorityColor)
            .frame(width: 4, height: 44)
    }
    
    private var priorityColor: Color {
        switch task.priority {
        case .high:
            return .red
        case .medium:
            return .orange
        case .low:
            return .blue
        }
    }
}

// MARK: - Preview
struct MyTasksView_Previews: PreviewProvider {
    static var previews: some View {
        MyTasksView()
    }
}
