//
//  ReplenishmentView.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  ReplenishmentView.swift
//  StoreFlow
//
//  Replenishment workflow view
//

import SwiftUI

struct ReplenishmentView: View {
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "arrow.triangle.2.circlepath")
                .font(.system(size: 64))
                .foregroundColor(.green)
            
            Text("Replenishment")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Efficiently restock shelves using MatrixScan Pick to identify and scan multiple items at once.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 32)
            
            VStack(alignment: .leading, spacing: 12) {
                FeaturePoint(text: "Scan multiple items simultaneously")
                FeaturePoint(text: "Track replenishment progress")
                FeaturePoint(text: "Identify low-stock items")
                FeaturePoint(text: "Update inventory levels")
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Replenishment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ReplenishmentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ReplenishmentView()
        }
    }
}
