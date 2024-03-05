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
    @State var season = 1
    
    var body: some View {
        ScrollView {
            VStack {
                MainDetailsView(
                    image: show.image?.original ?? "",
                    title: show.name ?? "",
                    description: show.summary ?? ""
                )
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Season \(season)")
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
                    
                    Divider()
                    
                    Text("More info")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    if let genres = show.genres {
                        InfoView(title: "Genre", info: genres.first ?? "" )
                    }
                
                    if let year = show.premiered {
                        InfoView(title: "Released", info: "\(year.prefix(4))")
                    }
                    
                    if let averageRuntime = show.averageRuntime  {
                        InfoView(title: "Average runtime", info: "\(averageRuntime) minutes")
                    }
                    
                    if let status = show.status {
                        InfoView(title: "Status", info: status)
                    }
                    
                    if let rating = show.rating?.average {
                        InfoView(title: "Rating", info: "\(rating)")
                    }
                    
                    Divider()
                    
                    if let cast = viewModel.cast {
                        Text("Cast")
                            .font(.title)
                            .fontWeight(.bold)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 25) {
                                ForEach(cast) { member in
                                    CastDetail(cast: member)
                                }
                                .frame(maxWidth: 150)
                            }
                            .padding()
                        }
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
