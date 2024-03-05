//
//  EpisodeDetailsViewModel.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import Combine

final class EpisodeDetailsViewModel: ObservableObject {
    @Published var castAndGuests: [Cast]?
    private var cancellable: AnyCancellable?
    private var interactor: TVMazeInteractorProtocol

    init(interactor: TVMazeInteractorProtocol = TVMazeInteractor()) {
        self.interactor = interactor
    }
    
    func requestGuestCasts(for episode: Int) {
        cancellable = interactor.fetchGuestCast(for: episode)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { cast in
                self.castAndGuests = cast
            }
    }
}
