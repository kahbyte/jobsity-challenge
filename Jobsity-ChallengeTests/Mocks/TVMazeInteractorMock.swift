//
//  TVMazeInteractorMock.swift
//  Jobsity-ChallengeTests
//
//  Created by Kauê Sales on 04/03/24.
//

import Combine
import Foundation

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
}
