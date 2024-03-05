//
//  EpisodeDetailsView.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import SwiftUI

struct MainDetailsView: View {
    var image: String
    var title: String
    var description: String
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack(spacing: 8) {
            AsyncImage(url: URL(string: image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } placeholder: {
                Color.gray
            }
            Text(title)
                .font(.title)
                .fontWeight(.bold)
            
            Text(description)
                .lineLimit(isExpanded ? nil : 3)
                .overlay(
                    Button(action: {
                        isExpanded.toggle()
                    }) {
                        Text(isExpanded ? "LESS" : "MORE")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .clipped()
                    }
                    , alignment: .bottomTrailing
                )
            
        }
    }
}

#Preview {
    MainDetailsView(
        image: "https://static.tvmaze.com/uploads/images/original_untouched/457/1142533.jpg",
        title: "Ted Lasso",
        description: "<p><b>Ted Lasso </b>centers on an idealistic — and clueless — all-American football coach hired to manage an English football club — despite having no soccer coaching experience at all.</p>"
    )
}
