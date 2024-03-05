//  EpisodeDetailsViewModelTests.swift
//  Jobsity-ChallengeTests
//
//  Created by Kauê Sales on 04/03/24.
//

import XCTest
import Combine
@testable import Jobsity_Challenge

final class EpisodeDetailsViewModelTests: XCTestCase {
    var viewModel: EpisodeDetailsViewModel!
    var interactorMock: TVMazeInteractorMock!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        interactorMock = TVMazeInteractorMock()
        viewModel = EpisodeDetailsViewModel(interactor: interactorMock)
        cancellables = []
    }
    
    override func tearDown() {
        viewModel = nil
        interactorMock = nil
        cancellables = nil
        super.tearDown()
    }
    
    func test_requestGuestCasts_whenFetchGuestCastFails_expectCastAndGuestsNil() {
        interactorMock.guestCastListToBeReturned = []
        interactorMock.guestCastListError = NSError(domain: "", code: -1, userInfo: nil)
        
        let expectation = XCTestExpectation(description: "Fetch guest cast")
        
        viewModel.$castAndGuests
            .sink { cast in
                if cast == nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        viewModel.requestGuestCasts(for: 1)
        
        wait(for: [expectation], timeout: 1.0)
        interactorMock.verifyFetchGuestCastWasCalledOnce()
    }
}
