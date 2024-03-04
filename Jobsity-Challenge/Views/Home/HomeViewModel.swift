//
//  HomeViewModel.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import Combine

final class HomeViewModel: ObservableObject {
    @Published var list: [ShowDetailsModel] = []
    @Published var searchList: [ShowDetailsModel] = []
    private var cancellable: AnyCancellable?
    private var interactor: TVMazeInteractorProtocol

    init(interactor: TVMazeInteractorProtocol = TVMazeInteractor()) {
        self.interactor = interactor
    }
    
    func requestShowList(page: Int) {
        cancellable = interactor.fetchShowList(page: page)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { details in
                self.list.append(contentsOf: details)
            }
    }
    
    func showLookup(_ term: String) {
        cancellable = interactor.fetchShowLookup(term)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { lookup in
                self.searchList = lookup.compactMap { $0.show }
            }
    }
}
