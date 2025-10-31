//
//  TopStockView.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  TopStockView.swift
//  StoreFlow
//
//  Top Stock workflow view
//

import SwiftUI

struct TopStockView: View {
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "arrow.down.to.line")
                .font(.system(size: 64))
                .foregroundColor(.orange)
            
            Text("Top Stock")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Move items from top stock to shelf level using MatrixScan Pick for efficient downstocking.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 32)
            
            VStack(alignment: .leading, spacing: 12) {
                FeaturePoint(text: "Scan items on top shelves")
                FeaturePoint(text: "Track downstocking progress")
                FeaturePoint(text: "Prioritize high-demand items")
                FeaturePoint(text: "Update shelf locations")
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Top Stock")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct TopStockView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            TopStockView()
        }
    }
}
