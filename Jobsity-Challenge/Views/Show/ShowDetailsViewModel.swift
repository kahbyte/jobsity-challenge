//
//  ShowDetailsViewModel.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import Combine

final class ShowDetailsViewModel: ObservableObject {
    @Published var episodes: [EpisodeModel] = []
    @Published var cast: [Cast]?
    private var cancellable: AnyCancellable?
    private var interactor: TVMazeInteractorProtocol

    init(interactor: TVMazeInteractorProtocol = TVMazeInteractor()) {
        self.interactor = interactor
    }
    
    func requestEpisodesList(for showId: Int) {
        cancellable = interactor.fetchEpisodeList(for: showId)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] episodes in
                self?.episodes = episodes
                self?.requestCast(for: showId)
            }
    }
    
    func requestCast(for showId: Int) {
        cancellable = interactor.fetchCast(for: showId)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { cast in
                self.cast = cast
            }
    }
}
