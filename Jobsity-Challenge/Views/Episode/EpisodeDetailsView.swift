//
//  EpisodeDetailsView.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import SwiftUI

struct EpisodeDetailsView: View {
    let showName: String
    let episode: EpisodeModel
    
    @StateObject var viewModel: EpisodeDetailsViewModel = .init()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: episode.image?.original ?? "")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: .infinity, maxHeight: 200)
                            .clipped()
                            .padding()
                    } placeholder: {
                        Color.gray
                    }
                    Text(showName)
                        .foregroundColor(.secondary)
                    
                    Text(episode.name ?? "")
                        .font(.title)
                    
                    Text("S:\(episode.season ?? 0), E:\(episode.number ?? 0): \(episode.summary ?? "")")
                    
                    Divider()
                }
                VStack(alignment: .leading) {
                    InfoView(title: "Duration", info: "\(episode.runtime ?? 0) minutes")
                    InfoView(title: "Rating", info: "\(episode.rating?.average ?? 0)")
                    InfoView(title: "Released", info: "\(episode.airdate ?? ""), \(episode.airtime ?? "")")
                }
                
                Divider()
                
                if let cast = viewModel.castAndGuests, !cast.isEmpty {
                    Text("Cast and Guests")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 25) {
                            ForEach(cast) { member in
                                NavigationLink(destination: PersonDetailView(cast: member)) {
                                    CastDetail(cast: member)
                                }
                            }
                            .frame(maxWidth: 150)
                        }
                        .padding()
                    }
                }
                
            }
            .onAppear {
                viewModel.requestGuestCasts(for: episode.id ?? 0)
            }
        }
    }
}

#Preview {
    EpisodeDetailsView(showName: "Ted Lasso", episode: JSONReader.load("EpisodeModelMock"))
}
