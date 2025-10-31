//
//  ReceivingView.swift
//  StoreFlow
//
//  Receiving workflow view
//

import SwiftUI

struct ReceivingView: View {
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "shippingbox.and.arrow.backward")
                .font(.system(size: 64))
                .foregroundColor(.teal)
            
            Text("Receiving")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Count and verify incoming shipments using MatrixScan Count for fast and accurate receiving.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 32)
            
            VStack(alignment: .leading, spacing: 12) {
                FeaturePoint(text: "Count items automatically")
                FeaturePoint(text: "Verify against purchase orders")
                FeaturePoint(text: "Identify discrepancies")
                FeaturePoint(text: "Update inventory")
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Receiving")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ReceivingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReceivingView()
        }
    }
}
