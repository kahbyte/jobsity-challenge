//
//  RequestMock.swift
//  Jobsity-ChallengeTests
//
//  Created by Kauê Sales on 04/03/24.
//

import Foundation
import Combine
import XCTest

@testable import Jobsity_Challenge

final class RequestMock: Request {
    var dataMock: Data = .init()
    var errorMock: APIError? = nil
    
    private(set) var fetchArgs: [(url: URL, type: Any.Type)] = []
    func fetch<T: Decodable>(from url: URL, as type: T.Type) -> AnyPublisher<T, Error> {
        fetchArgs.append((url, type))
        if let error = errorMock{
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        if let decodedData = try? JSONDecoder().decode(T.self, from: dataMock) {
            return Just(decodedData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
    }
}

extension RequestMock {
    func verifyFetchWasCalledOnce(file: StaticString = #file, line: UInt = #line) {
        guard fetchArgs.count == 1 else {
            XCTFail("Expected 1, but was called \(fetchArgs.count) times")
            return
        }
    }
    
    func verifyFetchWasNeverCalled(file: StaticString = #file, line: UInt = #line) {
        guard fetchArgs.count == 0 else {
            XCTFail("Expected 0, but was called \(fetchArgs.count) times")
            return
        }
    }
}
