//
//  HomeView.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  HomeView.swift
//  StoreFlow
//
//  Main home dashboard view
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Welcome Header
                    welcomeHeader
                    
                    // Task Summary Cards
                    taskSummarySection
                    
                    // Quick Actions Grid
                    quickActionsSection
                    
                    // Recent Activity
                    recentActivitySection
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await viewModel.refresh()
            }
        }
    }
    
    // MARK: - Welcome Header
    private var welcomeHeader: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Welcome back,")
                .font(.title3)
                .foregroundColor(.secondary)
            
            Text(viewModel.userName)
                .font(.largeTitle)
                .fontWeight(.bold)
            
            HStack {
                Image(systemName: "building.2")
                    .foregroundColor(.secondary)
                Text("Store #\(viewModel.storeNumber)")
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Text(viewModel.currentDate)
                    .foregroundColor(.secondary)
            }
            .font(.subheadline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    // MARK: - Task Summary Section
    private var taskSummarySection: some View {
        VStack(spacing: 12) {
            HStack {
                Text("My Tasks")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                NavigationLink(destination: MyTasksView()) {
                    Text("View All")
                        .font(.subheadline)
                        .foregroundColor(.accentColor)
                }
            }
            
            HStack(spacing: 12) {
                TaskSummaryCard(
                    title: "Not Started",
                    count: viewModel.notStartedCount,
                    color: .blue,
                    icon: "circle"
                )
                
                TaskSummaryCard(
                    title: "In Progress",
                    count: viewModel.inProgressCount,
                    color: .orange,
                    icon: "circle.lefthalf.filled"
                )
                
                TaskSummaryCard(
                    title: "Complete",
                    count: viewModel.completeCount,
                    color: .green,
                    icon: "checkmark.circle.fill"
                )
            }
        }
    }
    
    // MARK: - Quick Actions Section
    private var quickActionsSection: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Quick Actions")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                QuickActionTile(
                    title: "Order Fulfillment",
                    icon: "shippingbox",
                    color: .blue,
                    destination: AnyView(OrderFulfillmentView())
                )
                
                QuickActionTile(
                    title: "Shelf Capture",
                    icon: "camera",
                    color: .purple,
                    destination: AnyView(ShelfCaptureView())
                )
                
                QuickActionTile(
                    title: "Replenishment",
                    icon: "arrow.triangle.2.circlepath",
                    color: .green,
                    destination: AnyView(ReplenishmentView())
                )
                
                QuickActionTile(
                    title: "Top Stock",
                    icon: "arrow.down.to.line",
                    color: .orange,
                    destination: AnyView(TopStockView())
                )
                
                QuickActionTile(
                    title: "Expiration",
                    icon: "calendar.badge.exclamationmark",
                    color: .red,
                    destination: AnyView(ExpirationView())
                )
                
                QuickActionTile(
                    title: "Receiving",
                    icon: "shippingbox.and.arrow.backward",
                    color: .teal,
                    destination: AnyView(ReceivingView())
                )
            }
        }
    }
    
    // MARK: - Recent Activity Section
    private var recentActivitySection: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Recent Activity")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
            VStack(spacing: 8) {
                ForEach(viewModel.recentActivities) { activity in
                    RecentActivityRow(activity: activity)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}

// MARK: - Task Summary Card
struct TaskSummaryCard: View {
    let title: String
    let count: Int
    let color: Color
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text("\(count)")
                .font(.title)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Quick Action Tile
struct QuickActionTile: View {
    let title: String
    let icon: String
    let color: Color
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(color)
                    .cornerRadius(12)
                
                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}

// MARK: - Recent Activity Row
struct RecentActivityRow: View {
    let activity: RecentActivity
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: activity.icon)
                .font(.title3)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(activity.color)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(activity.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                
                Text(activity.subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Text(activity.timeAgo)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
