//
//  EpisodeView.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import SwiftUI

struct EpisodeView: View {
    var episode: EpisodeModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: episode.image?.original ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 300, height: 200)
                    .scaledToFill()
                    .clipped()
            } placeholder: {
                Color.gray
            }
            
            Text("Episode \(episode.number ?? 0)")
                .foregroundStyle(.secondary)
            
            Text(episode.name ?? "")
                .font(.title)
                .fontWeight(.bold)
                .lineLimit(1)
            
            Text(episode.summary ?? "")
                .font(.body)
                .foregroundColor(.gray)
                .lineLimit(2)
            
            Button(action: {
                // Ação do botão
            }) {
                Text("Detalhes")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}

#Preview {
    EpisodeView(episode: JSONReader.load("EpisodeModelMock"))
}
