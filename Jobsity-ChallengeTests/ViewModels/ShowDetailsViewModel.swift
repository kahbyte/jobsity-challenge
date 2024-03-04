//
//  ShowDetailsViewModelTests.swift
//  Jobsity-ChallengeTests
//
//  Created by Kauê Sales on 04/03/24.
//

import Combine
import XCTest

@testable import Jobsity_Challenge

final class ShowDetailsViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    private var interactorMock: TVMazeInteractorMock!
    private var sut: ShowDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        interactorMock = .init()
        sut = ShowDetailsViewModel(interactor: interactorMock)
    }
    
    override func tearDown() {
        cancellables.removeAll()
        interactorMock = nil
        sut = nil
        super.tearDown()
    }
    
    func test_requestEpisodesList_withValidShowId_shouldReturnExpectedData() {
        let dummyEpisode: EpisodeModel = JSONReader.load("EpisodeModelMock")
        interactorMock.episodeListToBeReturned = [dummyEpisode]
        
        sut.requestEpisodesList(for: 1)
        
        XCTAssertEqual(sut.episodes.count, 1)
        XCTAssertEqual(sut.episodes.first?.id, dummyEpisode.id)
        XCTAssertEqual(sut.episodes.first?.name, dummyEpisode.name)
        XCTAssertEqual(interactorMock.fetchEpisodeListArgs, [1])
    }
    
    func test_requestEpisodesList_withInvalidShowId_shouldPrintError() {
        interactorMock.episodeListError = APIError.invalidURL
        
        sut.requestEpisodesList(for: -1)
        
        XCTAssertEqual(sut.episodes.count, 0)
        XCTAssertEqual(interactorMock.fetchEpisodeListArgs, [-1])
    }
    
    func test_requestCast_withValidShowId_shouldReturnExpectedData() {
        let dummyCast: Cast = JSONReader.load("CastDetailsMock")
        interactorMock.castListToBeReturned = [dummyCast]
        
        sut.requestCast(for: 1)
        
        XCTAssertEqual(sut.cast?.count, 1)
        XCTAssertEqual(sut.cast?.first?.id, dummyCast.id)
        XCTAssertEqual(sut.cast?.first?.person.name, dummyCast.person.name)
        XCTAssertEqual(interactorMock.fetchCastArgs, [1])
    }
    
    func test_requestCast_withInvalidShowId_shouldPrintError() {
        interactorMock.castListError = APIError.invalidURL
        
        sut.requestCast(for: -1)
        
        XCTAssertNil(sut.cast)
        XCTAssertEqual(interactorMock.fetchCastArgs, [-1])
    }
    
}
