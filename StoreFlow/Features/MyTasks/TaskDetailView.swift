//
//  TaskDetailView.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  TaskDetailView.swift
//  StoreFlow
//
//  Detail view for individual task
//

import SwiftUI

struct TaskDetailView: View {
    let task: Task
    @ObservedObject var viewModel: MyTasksViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingDeleteConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Priority and Status Section
                priorityStatusSection
                
                // Task Information
                taskInfoSection
                
                // Related Feature Section
                if let feature = task.relatedFeature {
                    relatedFeatureSection(feature)
                }
                
                // Action Buttons
                actionButtons
            }
            .padding(16)
        }
        .navigationTitle("Task Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button(role: .destructive, action: {
                        showingDeleteConfirmation = true
                    }) {
                        Label("Delete Task", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
        .confirmationDialog("Delete Task", isPresented: $showingDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                viewModel.deleteTask(task.id)
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete this task?")
        }
    }
    
    // MARK: - Priority and Status Section
    private var priorityStatusSection: some View {
        HStack(spacing: 16) {
            // Priority Badge
            VStack(alignment: .leading, spacing: 4) {
                Text("Priority")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(spacing: 6) {
                    Circle()
                        .fill(priorityColor)
                        .frame(width: 8, height: 8)
                    
                    Text(task.priority.displayName)
                        .font(.headline)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(10)
            
            // Status Badge
            VStack(alignment: .leading, spacing: 4) {
                Text("Status")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(task.status.displayName)
                    .font(.headline)
                    .foregroundColor(statusColor)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(10)
        }
    }
    
    // MARK: - Task Info Section
    private var taskInfoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Title
            VStack(alignment: .leading, spacing: 4) {
                Text("Task")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(task.title)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            
            // Description
            if let description = task.description {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Description")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(description)
                        .font(.body)
                }
            }
            
            // Due Time
            if let dueTime = task.formattedDueTime {
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.secondary)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Due")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text(dueTime)
                            .font(.body)
                            .foregroundColor(task.isOverdue ? .red : .primary)
                    }
                    
                    if task.isOverdue && task.status != .complete {
                        Spacer()
                        Text("OVERDUE")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.red)
                            .cornerRadius(4)
                    }
                }
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(10)
    }
    
    // MARK: - Related Feature Section
    private func relatedFeatureSection(_ feature: Task.FeatureType) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Related Workflow")
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: feature.iconName)
                    .font(.title2)
                    .foregroundColor(.accentColor)
                    .frame(width: 44, height: 44)
                    .background(Color.accentColor.opacity(0.1))
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(feature.displayName)
                        .font(.headline)
                    
                    Text("Tap to open workflow")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(.secondarySystemGroupedBackground))
            .cornerRadius(10)
            .onTapGesture {
                // TODO: Navigate to related feature
                // This will be implemented when feature navigation is set up
            }
        }
    }
    
    // MARK: - Action Buttons
    private var actionButtons: some View {
        VStack(spacing: 12) {
            if task.status != .complete {
                // Mark as Complete Button
                Button(action: {
                    viewModel.updateTaskStatus(task.id, status: .complete)
                }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Mark as Complete")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                
                // Status Change Buttons
                if task.status == .notStarted {
                    Button(action: {
                        viewModel.updateTaskStatus(task.id, status: .inProgress)
                    }) {
                        HStack {
                            Image(systemName: "play.circle")
                            Text("Start Task")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                } else if task.status == .inProgress {
                    Button(action: {
                        viewModel.updateTaskStatus(task.id, status: .notStarted)
                    }) {
                        HStack {
                            Image(systemName: "pause.circle")
                            Text("Pause Task")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            } else {
                // Reopen Task Button
                Button(action: {
                    viewModel.updateTaskStatus(task.id, status: .notStarted)
                }) {
                    HStack {
                        Image(systemName: "arrow.counterclockwise.circle")
                        Text("Reopen Task")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
        }
    }
    
    // MARK: - Helper Properties
    private var priorityColor: Color {
        switch task.priority {
        case .high: return .red
        case .medium: return .orange
        case .low: return .blue
        }
    }
    
    private var statusColor: Color {
        switch task.status {
        case .notStarted: return .secondary
        case .inProgress: return .orange
        case .complete: return .green
        }
    }
}

// MARK: - Preview
struct TaskDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TaskDetailView(
                task: Task(
                    title: "Complete Morning Pick Lists",
                    description: "Process all pending customer orders from overnight",
                    priority: .high,
                    dueTime: Date(),
                    relatedFeature: .orderFulfillment,
                    status: .inProgress
                ),
                viewModel: MyTasksViewModel()
            )
        }
    }
}
