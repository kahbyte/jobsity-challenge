//
//  TVMazeInteractorMock.swift
//  Jobsity-ChallengeTests
//
//  Created by Kauê Sales on 04/03/24.
//

import Combine
import XCTest

@testable import Jobsity_Challenge

final class TVMazeInteractorMock: TVMazeInteractorProtocol {
    var showList: [ShowDetailsModel] = []
    var showDetails: ShowDetailsModel?
    var showLookup: [ShowLookupModel] = []
    
    var showListError: Error?
    var showDetailsError: Error?
    var showLookupError: Error?
    
    private(set) var fetchShowListArgs: [Int] = []
    func fetchShowList(page: Int) -> AnyPublisher<[ShowDetailsModel], Error> {
        fetchShowListArgs.append(page)
        
        if let error = showListError {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(showList)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    private(set) var fetchShowDetailsArgs: [Int] = []
    func fetchShowDetails(showId: Int) -> AnyPublisher<ShowDetailsModel, Error> {
        fetchShowDetailsArgs.append(showId)
        
        if let error = showDetailsError {
            return Fail(error: error).eraseToAnyPublisher()
        } else if let showDetails = showDetails {
            return Just(showDetails)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
    }
    
    private(set) var fetchShowLookupArgs: [String] = []
    func fetchShowLookup(_ term: String) -> AnyPublisher<[ShowLookupModel], Error> {
        fetchShowLookupArgs.append(term)
        
        if let error = showLookupError {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(showLookup)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    

    var episodeListError: Error?
    var episodeListToBeReturned: [EpisodeModel] = []
    private(set) var fetchEpisodeListArgs: [Int] = []
    func fetchEpisodeList(for showId: Int) -> AnyPublisher<[Jobsity_Challenge.EpisodeModel], Error> {
        fetchEpisodeListArgs.append(showId)
        
        if let error = episodeListError {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(episodeListToBeReturned)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }

    var castListToBeReturned: [Cast] = []
    var castListError: Error?
    private(set) var fetchCastArgs: [Int] = []
    func fetchCast(for showId: Int) -> AnyPublisher<[Jobsity_Challenge.Cast], Error> {
        fetchCastArgs.append(showId)
        
        if let error = castListError {
            return Fail(error: error).eraseToAnyPublisher()
        } else {
            return Just(castListToBeReturned)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}

extension TVMazeInteractorMock {
    func verifyFetchShowListWasCalledOnce(file: StaticString = #file, line: UInt = #line) {
        guard fetchShowListArgs.count == 1 else {
            XCTFail("Expected 1, but was called \(fetchShowListArgs.count) times", file: file, line: line)
            return
        }
    }
    
    func verifyFetchShowDetailsWasCalledOnce(file: StaticString = #file, line: UInt = #line) {
        guard fetchShowDetailsArgs.count == 1 else {
            XCTFail("Expected 1, but was called \(fetchShowDetailsArgs.count) times", file: file, line: line)
            return
        }
    }
    
    func verifyFetchShowLookupWasCalledOnce(file: StaticString = #file, line: UInt = #line) {
        guard fetchShowLookupArgs.count == 1 else {
            XCTFail("Expected 1, but was called \(fetchShowLookupArgs.count) times", file: file, line: line)
            return
        }
    }
    
    func verifyFetchEpisodeListWasCalledOnce(file: StaticString = #file, line: UInt = #line) {
        guard fetchEpisodeListArgs.count == 1 else {
            XCTFail("Expected 1, but was called \(fetchEpisodeListArgs.count) times", file: file, line: line)
            return
        }
    }
    
    func verifyFetchCastWasCalledOnce(file: StaticString = #file, line: UInt = #line) {
        guard fetchCastArgs.count == 1 else {
            XCTFail("Expected 1, but was called \(fetchCastArgs.count) times", file: file, line: line)
            return
        }
    }

    func verifyFetchShowListWasNeverCalled(file: StaticString = #file, line: UInt = #line) {
        guard fetchShowListArgs.count == 0 else {
            XCTFail("Expected 0, but was called \(fetchShowListArgs.count) times", file: file, line: line)
            return
        }
    }

    func verifyFetchShowDetailsWasNeverCalled(file: StaticString = #file, line: UInt = #line) {
        guard fetchShowDetailsArgs.count == 0 else {
            XCTFail("Expected 0, but was called \(fetchShowDetailsArgs.count) times", file: file, line: line)
            return
        }
    }

    func verifyFetchShowLookupWasNeverCalled(file: StaticString = #file, line: UInt = #line) {
        guard fetchShowLookupArgs.count == 0 else {
            XCTFail("Expected 0, but was called \(fetchShowLookupArgs.count) times", file: file, line: line)
            return
        }
    }

    func verifyFetchEpisodeListWasNeverCalled(file: StaticString = #file, line: UInt = #line) {
        guard fetchEpisodeListArgs.count == 0 else {
            XCTFail("Expected 0, but was called \(fetchEpisodeListArgs.count) times", file: file, line: line)
            return
        }
    }

    func verifyFetchCastWasNeverCalled(file: StaticString = #file, line: UInt = #line) {
        guard fetchCastArgs.count == 0 else {
            XCTFail("Expected 0, but was called \(fetchCastArgs.count) times", file: file, line: line)
            return
        }
    }
}
