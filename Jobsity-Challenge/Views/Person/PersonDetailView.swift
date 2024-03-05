//
//  PersonDetailView.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import SwiftUI

struct PersonDetailView: View {
    let cast: Cast
    
    @StateObject var viewModel: PersonDetailViewModel = .init()
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    ProfilePicture(imageURL: cast.person.image?.original ?? "")
                        .frame(width: 200, height: 200)
                        .scaledToFill()
                    
                    Text(cast.person.name ?? "")
                        .font(.title)
                        .foregroundColor(.primary)
                    
                    HStack {
                        Text(cast.person.birthday ?? "")
                        Text("-")
                        Text("age / deathday")
                    }
                    
                    Text(cast.person.country?.name ?? "")
                }
                .foregroundColor(.secondary)
                
                Divider()
                
                if let appearances = viewModel.personAppearances {
                    Text("Appearances")
                        .font(.title)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(appearances) { show in
                            NavigationLink(destination: ShowDetailsView(show: show)) {
                                TVShowVerticalView(showDetails: show)
                                    .frame(width: 100)
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                        }
                    }
                    .padding()
                } else {
                  Text("No work information found")
                }
            }
        }
        .onAppear {
            viewModel.fetchAppearances(for: cast.id)
        }
    }
}

#Preview {
    PersonDetailView(cast: JSONReader.load("CastDetailsMock"))
}
