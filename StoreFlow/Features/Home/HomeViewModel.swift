//
//  HomeViewModel.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  HomeViewModel.swift
//  StoreFlow
//
//  ViewModel for Home dashboard
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var userName: String = "John Smith"
    @Published var storeNumber: String = "1234"
    @Published var currentDate: String = ""
    
    @Published var notStartedCount: Int = 0
    @Published var inProgressCount: Int = 0
    @Published var completeCount: Int = 0
    
    @Published var recentActivities: [RecentActivity] = []
    
    // MARK: - Private Properties
    private let taskService: TaskServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(taskService: TaskServiceProtocol = TaskService.shared) {
        self.taskService = taskService
        setupDateFormatter()
        loadUserInfo()
        loadTaskCounts()
        loadRecentActivities()
        setupSubscriptions()
    }
    
    // MARK: - Public Methods
    @MainActor
    func refresh() async {
        loadTaskCounts()
        loadRecentActivities()
        
        // Simulate network delay
        try? await Task.sleep(nanoseconds: 1_000_000_000)
    }
    
    // MARK: - Private Methods
    private func setupDateFormatter() {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        currentDate = formatter.string(from: Date())
    }
    
    private func loadUserInfo() {
        // Load from UserDefaults or use mock data
        if let savedName = UserDefaults.standard.string(forKey: "userName") {
            userName = savedName
        }
        
        if let savedStore = UserDefaults.standard.string(forKey: "storeNumber") {
            storeNumber = savedStore
        }
    }
    
    private func loadTaskCounts() {
        notStartedCount = taskService.getTaskCount(for: .notStarted)
        inProgressCount = taskService.getTaskCount(for: .inProgress)
        completeCount = taskService.getTaskCount(for: .complete)
    }
    
    private func loadRecentActivities() {
        // In a real app, this would come from a service
        recentActivities = [
            RecentActivity(
                title: "Completed Order #1234",
                subtitle: "Order Fulfillment",
                icon: "shippingbox.fill",
                color: .blue,
                timeAgo: "5m ago"
            ),
            RecentActivity(
                title: "Scanned 45 items",
                subtitle: "Replenishment - Aisle 3",
                icon: "arrow.triangle.2.circlepath",
                color: .green,
                timeAgo: "15m ago"
            ),
            RecentActivity(
                title: "Captured shelf images",
                subtitle: "Shelf Capture - Bakery",
                icon: "camera.fill",
                color: .purple,
                timeAgo: "1h ago"
            ),
            RecentActivity(
                title: "Received delivery",
                subtitle: "Receiving - 120 items",
                icon: "shippingbox.and.arrow.backward.fill",
                color: .teal,
                timeAgo: "2h ago"
            ),
            RecentActivity(
                title: "Checked expiration dates",
                subtitle: "Expiration Management",
                icon: "calendar.badge.exclamationmark",
                color: .red,
                timeAgo: "3h ago"
            )
        ]
    }
    
    private func setupSubscriptions() {
        taskService.getTasksPublisher()
            .sink { [weak self] _ in
                self?.loadTaskCounts()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Recent Activity Model
struct RecentActivity: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    let timeAgo: String
}
