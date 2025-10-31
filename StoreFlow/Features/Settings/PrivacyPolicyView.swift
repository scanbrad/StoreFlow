//
//  PrivacyPolicyView.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  PrivacyPolicyView.swift
//  StoreFlow
//
//  Privacy Policy view
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Privacy Policy")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Last Updated: October 30, 2025")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Divider()
                
                privacySection(
                    title: "Information We Collect",
                    content: "We collect information that you provide directly to us, including your name, employee ID, store location, and work-related data such as task completion and scanning activity."
                )
                
                privacySection(
                    title: "How We Use Your Information",
                    content: "We use the information we collect to provide, maintain, and improve our services, to process your requests, and to communicate with you about your account and our services."
                )
                
                privacySection(
                    title: "Data Security",
                    content: "We implement appropriate technical and organizational measures to protect the security of your personal information. However, no method of transmission over the Internet is 100% secure."
                )
                
                privacySection(
                    title: "Your Rights",
                    content: "You have the right to access, update, or delete your personal information. You may also have the right to restrict or object to certain processing of your data."
                )
                
                privacySection(
                    title: "Contact Us",
                    content: "If you have any questions about this Privacy Policy, please contact us at privacy@storeflow.com"
                )
            }
            .padding()
        }
        .navigationTitle("Privacy Policy")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func privacySection(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

// MARK: - Preview
struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            PrivacyPolicyView()
        }
    }
}
