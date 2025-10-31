//
//  MyTasksViewModel.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  MyTasksViewModel.swift
//  StoreFlow
//
//  ViewModel for My Tasks feature
//

import Foundation
import Combine

class MyTasksViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var tasks: [Task] = []
    @Published var filteredTasks: [Task] = []
    @Published var groupedTasks: [Task.TaskStatus: [Task]] = [:]
    
    // MARK: - Private Properties
    private let taskService: TaskServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var currentFilter: TaskFilter = .all
    private var currentSort: TaskSort = .priority
    
    // MARK: - Initialization
    init(taskService: TaskServiceProtocol = TaskService.shared) {
        self.taskService = taskService
        setupSubscriptions()
    }
    
    // MARK: - Public Methods
    func loadTasks() {
        tasks = taskService.getTasks()
        applyFilterAndSort()
    }
    
    func filterTasks(by filter: TaskFilter) {
        currentFilter = filter
        applyFilterAndSort()
    }
    
    func sortTasks(by sort: TaskSort) {
        currentSort = sort
        applyFilterAndSort()
    }
    
    func updateTaskStatus(_ taskId: UUID, status: Task.TaskStatus) {
        taskService.updateTaskStatus(id: taskId, status: status)
        loadTasks()
    }
    
    func deleteTask(_ taskId: UUID) {
        taskService.deleteTask(id: taskId)
        loadTasks()
    }
    
    func getTaskCount(for status: Task.TaskStatus) -> Int {
        return taskService.getTaskCount(for: status)
    }
    
    // MARK: - Private Methods
    private func setupSubscriptions() {
        taskService.getTasksPublisher()
            .sink { [weak self] tasks in
                self?.tasks = tasks
                self?.applyFilterAndSort()
            }
            .store(in: &cancellables)
    }
    
    private func applyFilterAndSort() {
        // Apply filter
        filteredTasks = tasks.filter { currentFilter.matches($0) }
        
        // Apply sort
        filteredTasks.sort { currentSort.compare($0, $1) }
        
        // Group by status
        groupTasks()
    }
    
    private func groupTasks() {
        groupedTasks = Dictionary(grouping: filteredTasks) { $0.status }
    }
}

// MARK: - Preview Helper
extension MyTasksViewModel {
    static var preview: MyTasksViewModel {
        let mockTasks = [
            Task(
                title: "Complete Morning Pick Lists",
                description: "Process all pending customer orders from overnight",
                priority: .high,
                dueTime: Date(),
                relatedFeature: .orderFulfillment,
                status: .inProgress
            ),
            Task(
                title: "Restock Dairy Section",
                description: "Replenish milk, yogurt, and cheese displays",
                priority: .high,
                dueTime: Calendar.current.date(byAdding: .hour, value: 1, to: Date()),
                relatedFeature: .replenishment,
                status: .notStarted
            ),
            Task(
                title: "Morning Shelf Audit",
                description: "Completed shelf condition check",
                priority: .medium,
                dueTime: Calendar.current.date(byAdding: .hour, value: -2, to: Date()),
                relatedFeature: .shelfCapture,
                status: .complete
            )
        ]
        
        let mockService = MockTaskService(tasks: mockTasks)
        return MyTasksViewModel(taskService: mockService)
    }
}
