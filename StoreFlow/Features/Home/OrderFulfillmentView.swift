//
//  OrderFulfillmentView.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  OrderFulfillmentView.swift
//  StoreFlow
//
//  Order Fulfillment workflow view
//

import SwiftUI

struct OrderFulfillmentView: View {
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "shippingbox")
                .font(.system(size: 64))
                .foregroundColor(.blue)
            
            Text("Order Fulfillment")
                .font(.title)
                .fontWeight(.bold)
            
            Text("This workflow uses Scandit SparkScan and MatrixScan Find to efficiently pick and fulfill customer orders.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 32)
            
            VStack(alignment: .leading, spacing: 12) {
                FeaturePoint(text: "Scan items quickly with SparkScan")
                FeaturePoint(text: "Find items using MatrixScan Find")
                FeaturePoint(text: "Track order completion progress")
                FeaturePoint(text: "Verify picked items")
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Order Fulfillment")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FeaturePoint: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
            Text(text)
                .font(.subheadline)
        }
    }
}

struct OrderFulfillmentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OrderFulfillmentView()
        }
    }
}
