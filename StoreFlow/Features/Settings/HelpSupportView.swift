//
//  HelpSupportView.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  HelpSupportView.swift
//  StoreFlow
//
//  Help and Support view
//

import SwiftUI

struct HelpSupportView: View {
    @State private var searchText = ""
    
    var body: some View {
        List {
            // Search Bar
            Section {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    
                    TextField("Search help topics", text: $searchText)
                }
            }
            
            // Quick Actions
            Section("Quick Actions") {
                NavigationLink(destination: TutorialsView()) {
                    Label("Video Tutorials", systemImage: "play.rectangle")
                }
                
                NavigationLink(destination: FAQView()) {
                    Label("Frequently Asked Questions", systemImage: "questionmark.circle")
                }
                
                NavigationLink(destination: ContactSupportView()) {
                    Label("Contact Support", systemImage: "envelope")
                }
            }
            
            // Common Topics
            Section("Common Topics") {
                NavigationLink(destination: TopicDetailView(topic: "Getting Started")) {
                    Label("Getting Started", systemImage: "star")
                }
                
                NavigationLink(destination: TopicDetailView(topic: "Using the Scanner")) {
                    Label("Using the Scanner", systemImage: "barcode.viewfinder")
                }
                
                NavigationLink(destination: TopicDetailView(topic: "Managing Tasks")) {
                    Label("Managing Tasks", systemImage: "checklist")
                }
                
                NavigationLink(destination: TopicDetailView(topic: "Order Fulfillment")) {
                    Label("Order Fulfillment", systemImage: "shippingbox")
                }
                
                NavigationLink(destination: TopicDetailView(topic: "Troubleshooting")) {
                    Label("Troubleshooting", systemImage: "wrench.and.screwdriver")
                }
            }
        }
        .navigationTitle("Help & Support")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Tutorials View
struct TutorialsView: View {
    var body: some View {
        List {
            ForEach(Tutorial.samples) { tutorial in
                NavigationLink(destination: TutorialDetailView(tutorial: tutorial)) {
                    TutorialRowView(tutorial: tutorial)
                }
            }
        }
        .navigationTitle("Tutorials")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TutorialRowView: View {
    let tutorial: Tutorial
    
    var body: some View {
        HStack(spacing: 12) {
            // Thumbnail
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.accentColor.opacity(0.2))
                .frame(width: 80, height: 60)
                .overlay(
                    Image(systemName: "play.fill")
                        .foregroundColor(.accentColor)
                )
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(tutorial.title)
                    .font(.headline)
                
                Text(tutorial.duration)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

// MARK: - FAQ View
struct FAQView: View {
    var body: some View {
        List {
            ForEach(FAQ.samples) { faq in
                DisclosureGroup {
                    Text(faq.answer)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 8)
                } label: {
                    Text(faq.question)
                        .font(.headline)
                }
            }
        }
        .navigationTitle("FAQ")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Contact Support View
struct ContactSupportView: View {
    @State private var subject = ""
    @State private var message = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        Form {
            Section("Contact Information") {
                HStack {
                    Image(systemName: "phone.fill")
                        .foregroundColor(.accentColor)
                    Text("1-800-SUPPORT")
                }
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .foregroundColor(.accentColor)
                    Text("support@storeflow.com")
                }
            }
            
            Section("Send a Message") {
                TextField("Subject", text: $subject)
                
                TextEditor(text: $message)
                    .frame(minHeight: 150)
            }
            
            Section {
                Button(action: {
                    showingConfirmation = true
                }) {
                    HStack {
                        Spacer()
                        Text("Send Message")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                }
                .disabled(subject.isEmpty || message.isEmpty)
            }
        }
        .navigationTitle("Contact Support")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Message Sent", isPresented: $showingConfirmation) {
            Button("OK") {
                subject = ""
                message = ""
            }
        } message: {
            Text("We'll get back to you within 24 hours.")
        }
    }
}

// MARK: - Topic Detail View
struct TopicDetailView: View {
    let topic: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Information about \(topic)")
                    .font(.body)
                
                Text("This is where detailed help content would appear for the selected topic.")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .navigationTitle(topic)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Tutorial Detail View
struct TutorialDetailView: View {
    let tutorial: Tutorial
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Video Placeholder
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.accentColor.opacity(0.2))
                    .frame(height: 220)
                    .overlay(
                        Image(systemName: "play.circle.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.accentColor)
                    )
                    .padding()
                
                // Description
                VStack(alignment: .leading, spacing: 12) {
                    Text(tutorial.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text(tutorial.description)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Tutorial")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Supporting Models
struct Tutorial: Identifiable {
    let id = UUID()
    let title: String
    let duration: String
    let description: String
    
    static let samples = [
        Tutorial(title: "Getting Started with StoreFlow", duration: "3:45", description: "Learn the basics of navigating the app"),
        Tutorial(title: "Scanning Barcodes", duration: "2:30", description: "How to use the barcode scanner effectively"),
        Tutorial(title: "Managing Your Tasks", duration: "4:15", description: "Organize and complete your daily tasks"),
        Tutorial(title: "Order Fulfillment Workflow", duration: "5:00", description: "Step-by-step guide to fulfilling orders"),
        Tutorial(title: "Shelf Capture Best Practices", duration: "3:20", description: "Tips for capturing quality shelf images")
    ]
}

struct FAQ: Identifiable {
    let id = UUID()
    let question: String
    let answer: String
    
    static let samples = [
        FAQ(question: "How do I scan a barcode?", answer: "Tap the scan button in any workflow, point your camera at the barcode, and wait for the beep. The app will automatically recognize and process the barcode."),
        FAQ(question: "What if a barcode won't scan?", answer: "Make sure the barcode is clean and well-lit. You can also manually enter the barcode number using the keyboard icon."),
        FAQ(question: "How do I mark a task as complete?", answer: "Open the task from My Tasks, then tap the 'Mark as Complete' button at the bottom of the screen."),
        FAQ(question: "Can I work offline?", answer: "Yes, the app works offline. Your data will sync automatically when you reconnect to the network."),
        FAQ(question: "How do I report a problem?", answer: "Use the Contact Support option in Help & Support to send us a message, or call our support line.")
    ]
}

// MARK: - Preview
struct HelpSupportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HelpSupportView()
        }
    }
}
