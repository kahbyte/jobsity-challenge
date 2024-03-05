//
//  PersonDetailViewModel.swift
//  Jobsity-Challenge
//
//  Created by Kauê Sales on 04/03/24.
//

import Combine

final class PersonDetailViewModel: ObservableObject {
    @Published var personAppearances: [ShowDetailsModel]?

    private var cancellable: AnyCancellable?
    private var interactor: TVMazeInteractorProtocol

    init(interactor: TVMazeInteractorProtocol = TVMazeInteractor()) {
        self.interactor = interactor
    }
    
    func fetchAppearances(for personId: Int) {
        cancellable = interactor.fetchAppearances(for: personId)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { castCredits in
                self.personAppearances = castCredits.compactMap { $0.embedded.show}
            }
    }
}
