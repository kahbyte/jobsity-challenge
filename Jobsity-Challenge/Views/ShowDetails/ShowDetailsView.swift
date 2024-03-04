//
//  ShowDetailsView.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import SwiftUI

struct ShowDetailsView: View {
    @ObservedObject var viewModel: ShowDetailsViewModel = .init()
    let show: ShowDetailsModel
    
    var body: some View {
        ScrollView {
            VStack {
                MainDetailsView(
                    image: show.image?.original ?? "",
                    title: show.name ?? "",
                    description: show.summary ?? ""
                )
                
                Divider()
                
                VStack(alignment: .leading) {
                    Text("Episodes")
                        .font(.title)
                    .fontWeight(.bold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.episodes) { episode in
                                EpisodeView(episode: episode)
                            }
                            .frame(maxWidth: 300)
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            viewModel.requestEpisodesList(for: show.id ?? 0)
        }
    }
}

#Preview {
    ShowDetailsView(show: JSONReader.load("ShowDetailsMock"))
}
