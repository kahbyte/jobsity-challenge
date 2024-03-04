//
//  ContentView.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 03/03/24.
//

import Combine
import SwiftUI

struct ContentView: View {
    private var interactor: TVMazeInteractor = .init()
    
    @State private var cancellable: AnyCancellable?
    @State private var title: String = "Faz a request vain"
    @State private var page: Int = 1
    @State private var list: [ShowDetailsModel] = []
    
    var body: some View {
        List(list) { show in
            Text(show.name ?? "")
                .onAppear {
                    if self.list.last == show {
                        page += 1
                        requestShowDetail()
                    }
                }
        }
        .padding()
        .onAppear {
            requestShowDetail()
        }
    }
    
    func requestShowDetail() {
        cancellable = interactor.fetchShowList(page: page)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { details in
                list.append(contentsOf: details)
                print(list.count)
            }
        
    }
}

#Preview {
    ContentView()
}
