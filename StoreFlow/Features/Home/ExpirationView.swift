//
//  ExpirationView.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  ExpirationView.swift
//  StoreFlow
//
//  Expiration Management workflow view
//

import SwiftUI

struct ExpirationView: View {
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "calendar.badge.exclamationmark")
                .font(.system(size: 64))
                .foregroundColor(.red)
            
            Text("Expiration Management")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Use Smart Label Capture to scan and track expiration dates on products automatically.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 32)
            
            VStack(alignment: .leading, spacing: 12) {
                FeaturePoint(text: "Scan expiration dates automatically")
                FeaturePoint(text: "Identify soon-to-expire items")
                FeaturePoint(text: "Generate removal lists")
                FeaturePoint(text: "Track compliance")
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Expiration Management")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExpirationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ExpirationView()
        }
    }
}
