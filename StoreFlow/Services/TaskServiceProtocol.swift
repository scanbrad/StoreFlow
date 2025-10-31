//
//  TaskServiceProtocol.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  TaskService.swift
//  StoreFlow
//
//  Service for managing tasks
//

import Foundation
import Combine

// MARK: - Task Service Protocol
protocol TaskServiceProtocol {
    func getTasks() -> [Task]
    func getTask(id: UUID) -> Task?
    func updateTaskStatus(id: UUID, status: Task.TaskStatus)
    func deleteTask(id: UUID)
    func getTaskCount(for status: Task.TaskStatus) -> Int
    func getTasksPublisher() -> AnyPublisher<[Task], Never>
}

// MARK: - Task Service Implementation
class TaskService: TaskServiceProtocol, ObservableObject {
    
    // MARK: - Singleton
    static let shared = TaskService()
    
    // MARK: - Published Properties
    @Published private(set) var tasks: [Task] = []
    
    // MARK: - Private Properties
    private let tasksSubject = CurrentValueSubject<[Task], Never>([])
    
    // MARK: - Initialization
    private init() {
        loadMockTasks()
    }
    
    // MARK: - Public Methods
    func getTasks() -> [Task] {
        return tasks
    }
    
    func getTask(id: UUID) -> Task? {
        return tasks.first { $0.id == id }
    }
    
    func updateTaskStatus(id: UUID, status: Task.TaskStatus) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        tasks[index].status = status
        tasksSubject.send(tasks)
    }
    
    func deleteTask(id: UUID) {
        tasks.removeAll { $0.id == id }
        tasksSubject.send(tasks)
    }
    
    func getTaskCount(for status: Task.TaskStatus) -> Int {
        return tasks.filter { $0.status == status }.count
    }
    
    func getTasksPublisher() -> AnyPublisher<[Task], Never> {
        return tasksSubject.eraseToAnyPublisher()
    }
    
    // MARK: - Private Methods
    private func loadMockTasks() {
        let calendar = Calendar.current
        let now = Date()
        
        tasks = [
            // High Priority - Not Started
            Task(
                id: UUID(),
                title: "Complete Morning Pick Lists",
                description: "Process all pending customer orders from overnight",
                priority: .high,
                dueTime: calendar.date(byAdding: .hour, value: 2, to: now),
                relatedFeature: .orderFulfillment,
                status: .notStarted,
                createdDate: calendar.date(byAdding: .day, value: -1, to: now) ?? now
            ),
            
            Task(
                id: UUID(),
                title: "Restock Dairy Section",
                description: "Replenish milk, yogurt, and cheese displays",
                priority: .high,
                dueTime: calendar.date(byAdding: .hour, value: 1, to: now),
                relatedFeature: .replenishment,
                status: .notStarted,
                createdDate: calendar.date(byAdding: .day, value: -1, to: now) ?? now
            ),
            
            // High Priority - In Progress
            Task(
                id: UUID(),
                title: "Check Expiration Dates - Bakery",
                description: "Scan all bakery items for upcoming expiration dates",
                priority: .high,
                dueTime: calendar.date(byAdding: .hour, value: 3, to: now),
                relatedFeature: .expiration,
                status: .inProgress,
                createdDate: calendar.date(byAdding: .hour, value: -2, to: now) ?? now
            ),
            
            // Medium Priority - Not Started
            Task(
                id: UUID(),
                title: "Receive Produce Delivery",
                description: "Count and verify incoming produce shipment",
                priority: .medium,
                dueTime: calendar.date(byAdding: .hour, value: 4, to: now),
                relatedFeature: .receiving,
                status: .notStarted,
                createdDate: calendar.date(byAdding: .day, value: -1, to: now) ?? now
            ),
            
            Task(
                id: UUID(),
                title: "Capture Shelf Images - Aisle 5",
                description: "Take photos of cereal and breakfast items for planogram review",
                priority: .medium,
                dueTime: calendar.date(byAdding: .hour, value: 5, to: now),
                relatedFeature: .shelfCapture,
                status: .notStarted,
                createdDate: calendar.date(byAdding: .day, value: -1, to: now) ?? now
            ),
            
            Task(
                id: UUID(),
                title: "Downstock Canned Goods",
                description: "Move items from top stock to shelf level in Aisle 3",
                priority: .medium,
                dueTime: calendar.date(byAdding: .hour, value: 6, to: now),
                relatedFeature: .topStock,
                status: .notStarted,
                createdDate: calendar.date(byAdding: .day, value: -1, to: now) ?? now
            ),
            
            // Medium Priority - In Progress
            Task(
                id: UUID(),
                title: "Afternoon Replenishment Round",
                description: "Check and restock high-traffic areas",
                priority: .medium,
                dueTime: calendar.date(byAdding: .hour, value: 4, to: now),
                relatedFeature: .replenishment,
                status: .inProgress,
                createdDate: calendar.date(byAdding: .hour, value: -1, to: now) ?? now
            ),
            
            // Low Priority - Not Started
            Task(
                id: UUID(),
                title: "Organize Backroom Bay A",
                description: "Reorganize overflow inventory in Bay A for better access",
                priority: .low,
                dueTime: calendar.date(byAdding: .day, value: 1, to: now),
                relatedFeature: nil,
                status: .notStarted,
                createdDate: calendar.date(byAdding: .day, value: -2, to: now) ?? now
            ),
            
            Task(
                id: UUID(),
                title: "Update Shelf Tags - Aisle 7",
                description: "Replace outdated price tags in snack aisle",
                priority: .low,
                dueTime: calendar.date(byAdding: .day, value: 1, to: now),
                relatedFeature: nil,
                status: .notStarted,
                createdDate: calendar.date(byAdding: .day, value: -2, to: now) ?? now
            ),
            
            // Completed Tasks
            Task(
                id: UUID(),
                title: "Morning Shelf Audit",
                description: "Completed shelf condition check for aisles 1-4",
                priority: .high,
                dueTime: calendar.date(byAdding: .hour, value: -2, to: now),
                relatedFeature: .shelfCapture,
                status: .complete,
                createdDate: calendar.date(byAdding: .day, value: -1, to: now) ?? now
            ),
            
            Task(
                id: UUID(),
                title: "Process Meat Department Orders",
                description: "Fulfilled all meat and deli customer orders",
                priority: .medium,
                dueTime: calendar.date(byAdding: .hour, value: -1, to: now),
                relatedFeature: .orderFulfillment,
                status: .complete,
                createdDate: calendar.date(byAdding: .day, value: -1, to: now) ?? now
            ),
            
            Task(
                id: UUID(),
                title: "Receive Frozen Delivery",
                description: "Counted and verified frozen food shipment",
                priority: .medium,
                dueTime: calendar.date(byAdding: .hour, value: -3, to: now),
                relatedFeature: .receiving,
                status: .complete,
                createdDate: calendar.date(byAdding: .day, value: -1, to: now) ?? now
            )
        ]
        
        tasksSubject.send(tasks)
    }
}

// MARK: - Mock Task Service (for previews)
class MockTaskService: TaskServiceProtocol {
    var tasks: [Task] = []
    
    init(tasks: [Task] = []) {
        self.tasks = tasks
    }
    
    func getTasks() -> [Task] {
        return tasks
    }
    
    func getTask(id: UUID) -> Task? {
        return tasks.first { $0.id == id }
    }
    
    func updateTaskStatus(id: UUID, status: Task.TaskStatus) {
        guard let index = tasks.firstIndex(where: { $0.id == id }) else { return }
        tasks[index].status = status
    }
    
    func deleteTask(id: UUID) {
        tasks.removeAll { $0.id == id }
    }
    
    func getTaskCount(for status: Task.TaskStatus) -> Int {
        return tasks.filter { $0.status == status }.count
    }
    
    func getTasksPublisher() -> AnyPublisher<[Task], Never> {
        return Just(tasks).eraseToAnyPublisher()
    }
}
