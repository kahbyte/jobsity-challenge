//
//  HomeView.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 03/03/24.
//

import SwiftUI
import Combine

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel = .init()
    @State private var title: String = "Faz a request vain"
    @State private var page: Int = 1
    @State private var searchText: String = ""
    
    var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText) {
                    viewModel.showLookup(searchText)
                }
                
                ScrollView {
                    if searchText.isEmpty {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.list) { show in
                                NavigationLink(destination: ShowDetailsView(show: show)) {
                                    TVShowVerticalView(showDetails: show)
                                        .frame(width: 100)
                                        .foregroundColor(.primary)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .onAppear {
                                            if viewModel.list.last == show {
                                                page += 1
                                                viewModel.requestShowList(page: page)
                                            }
                                    }
                                }
                            }
                        }
                    } else {
                        LazyVStack(alignment: .leading) {
                            ForEach(viewModel.searchList) { result in
                                NavigationLink(destination: ShowDetailsView(show: result)) {
                                    TVShowHorizontalView(showDetails: result)
                                        .frame(height: 100)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                }
                .padding()
                .onAppear {
                    viewModel.requestShowList(page: 1)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
