//
//  InfoCard.swift
//  ExploreCountries
//
//  Created by Heba on 23/01/2026.
//

import SwiftUI

struct InfoCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label(title, systemImage: icon)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            
            Text(value)
                .font(.system(.body, design: .rounded))
                .fontWeight(.semibold)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.8)))
    }
}
