//
//  ShelfCaptureView.swift
//  StoreFlow
//
//  Created by Brad Scott on 10/30/25.
//


//
//  ShelfCaptureView.swift
//  StoreFlow
//
//  Shelf Capture workflow view
//

import SwiftUI

struct ShelfCaptureView: View {
    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "camera")
                .font(.system(size: 64))
                .foregroundColor(.purple)
            
            Text("Shelf Capture")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Capture high-quality images of shelves for planogram compliance and inventory analysis.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.horizontal, 32)
            
            VStack(alignment: .leading, spacing: 12) {
                FeaturePoint(text: "Take photos of shelf sections")
                FeaturePoint(text: "Add notes and annotations")
                FeaturePoint(text: "Upload to cloud storage")
                FeaturePoint(text: "Review captured images")
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Shelf Capture")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ShelfCaptureView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ShelfCaptureView()
        }
    }
}
