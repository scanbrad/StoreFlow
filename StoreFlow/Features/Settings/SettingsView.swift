//
//  SettingsView.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  SettingsView.swift
//  StoreFlow
//
//  Main view for Settings feature
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showingLogoutConfirmation = false
    
    var body: some View {
        NavigationStack {
            List {
                // User Profile Section
                userProfileSection
                
                // Preferences Section
                preferencesSection
                
                // Scanner Settings Section
                scannerSettingsSection
                
                // Notifications Section
                notificationsSection
                
                // About Section
                aboutSection
                
                // Account Section
                accountSection
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .confirmationDialog("Sign Out", isPresented: $showingLogoutConfirmation) {
                Button("Sign Out", role: .destructive) {
                    viewModel.logout()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Are you sure you want to sign out?")
            }
        }
    }
    
    // MARK: - User Profile Section
    private var userProfileSection: some View {
        Section {
            HStack(spacing: 16) {
                // Avatar
                Circle()
                    .fill(Color.accentColor.opacity(0.2))
                    .frame(width: 60, height: 60)
                    .overlay(
                        Text(viewModel.userInitials)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.accentColor)
                    )
                
                // User Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.userName)
                        .font(.headline)
                    
                    Text(viewModel.userRole)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text("Store #\(viewModel.storeNumber)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding(.vertical, 8)
        }
    }
    
    // MARK: - Preferences Section
    private var preferencesSection: some View {
        Section("Preferences") {
            // Theme Toggle
            Toggle(isOn: $viewModel.isDarkModeEnabled) {
                Label("Dark Mode", systemImage: "moon.fill")
            }
            
            // Sound Effects
            Toggle(isOn: $viewModel.soundEffectsEnabled) {
                Label("Sound Effects", systemImage: "speaker.wave.2.fill")
            }
            
            // Haptic Feedback
            Toggle(isOn: $viewModel.hapticFeedbackEnabled) {
                Label("Haptic Feedback", systemImage: "hand.tap.fill")
            }
        }
    }
    
    // MARK: - Scanner Settings Section
    private var scannerSettingsSection: some View {
        Section("Scanner Settings") {
            // Auto-focus
            Toggle(isOn: $viewModel.scannerAutoFocus) {
                Label("Auto Focus", systemImage: "viewfinder.circle")
            }
            
            // Vibration on Scan
            Toggle(isOn: $viewModel.vibrationOnScan) {
                Label("Vibration on Scan", systemImage: "iphone.radiowaves.left.and.right")
            }
            
            // Beep on Scan
            Toggle(isOn: $viewModel.beepOnScan) {
                Label("Beep on Scan", systemImage: "speaker.wave.1")
            }
            
            // Scan Delay
            Picker(selection: $viewModel.scanDelay) {
                ForEach(ScanDelay.allCases, id: \.self) { delay in
                    Text(delay.displayName).tag(delay)
                }
            } label: {
                Label("Scan Delay", systemImage: "timer")
            }
        }
    }
    
    // MARK: - Notifications Section
    private var notificationsSection: some View {
        Section("Notifications") {
            // Task Reminders
            Toggle(isOn: $viewModel.taskRemindersEnabled) {
                Label("Task Reminders", systemImage: "bell.fill")
            }
            
            // Overdue Alerts
            Toggle(isOn: $viewModel.overdueAlertsEnabled) {
                Label("Overdue Alerts", systemImage: "exclamationmark.triangle.fill")
            }
            
            // Daily Summary
            Toggle(isOn: $viewModel.dailySummaryEnabled) {
                Label("Daily Summary", systemImage: "list.bullet.rectangle")
            }
        }
    }
    
    // MARK: - About Section
    private var aboutSection: some View {
        Section("About") {
            // App Version
            HStack {
                Label("Version", systemImage: "info.circle")
                Spacer()
                Text(viewModel.appVersion)
                    .foregroundColor(.secondary)
            }
            
            // Build Number
            HStack {
                Label("Build", systemImage: "hammer")
                Spacer()
                Text(viewModel.buildNumber)
                    .foregroundColor(.secondary)
            }
            
            // Help & Support
            NavigationLink(destination: HelpSupportView()) {
                Label("Help & Support", systemImage: "questionmark.circle")
            }
            
            // Privacy Policy
            NavigationLink(destination: PrivacyPolicyView()) {
                Label("Privacy Policy", systemImage: "hand.raised")
            }
            
            // Terms of Service
            NavigationLink(destination: TermsOfServiceView()) {
                Label("Terms of Service", systemImage: "doc.text")
            }
        }
    }
    
    // MARK: - Account Section
    private var accountSection: some View {
        Section {
            Button(action: {
                showingLogoutConfirmation = true
            }) {
                HStack {
                    Spacer()
                    Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.red)
                    Spacer()
                }
            }
        }
    }
}

// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
