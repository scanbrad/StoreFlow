//
//  TermsOfServiceView.swift
//  StoreFlow
//
//  Terms of Service view
//

import SwiftUI

struct TermsOfServiceView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Terms of Service")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Last Updated: October 30, 2025")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Divider()
                
                termsSection(
                    title: "Acceptance of Terms",
                    content: "By accessing and using StoreFlow, you accept and agree to be bound by the terms and provision of this agreement."
                )
                
                termsSection(
                    title: "Use License",
                    content: "Permission is granted to use StoreFlow for work-related purposes within your organization. This license shall automatically terminate if you violate any of these restrictions."
                )
                
                termsSection(
                    title: "User Responsibilities",
                    content: "You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account."
                )
                
                termsSection(
                    title: "Prohibited Uses",
                    content: "You may not use StoreFlow for any illegal purpose or to violate any laws. You may not attempt to gain unauthorized access to any portion of the app."
                )
                
                termsSection(
                    title: "Modifications",
                    content: "We reserve the right to modify or replace these Terms at any time. Continued use of the app after any changes constitutes acceptance of the new Terms."
                )
                
                termsSection(
                    title: "Contact",
                    content: "For questions about these Terms, please contact legal@storeflow.com"
                )
            }
            .padding()
        }
        .navigationTitle("Terms of Service")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func termsSection(title: String, content: String) -> some View {
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
struct TermsOfServiceView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TermsOfServiceView()
        }
    }
}
