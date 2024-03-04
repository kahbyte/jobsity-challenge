//
//  APIRequestTests.swift
//  Jobsity-ChallengeTests
//
//  Created by Kauê Sales on 03/03/24.
//

import XCTest

@testable import Jobsity_Challenge

final class APIRequestTests: XCTestCase {
    
    func test_errorDescriptions_invalidURL_shouldReturnExpectedDescriptions() {
        XCTAssertEqual(APIError.invalidURL.errorDescription, "Invalid URL")
    }

    func test_errorDescriptions_invalidResponse_shouldReturnExpectedDescriptions() {
        XCTAssertEqual(APIError.invalidResponse.errorDescription, "Invalid Response")
    }

    func test_errorDescriptions_decodingError_shouldReturnExpectedDescriptions() {
        XCTAssertEqual(APIError.decodingError.errorDescription, "Decoding Error")
    }

    func test_errorDescriptions_serverError_shouldReturnExpectedDescriptions() {
        XCTAssertEqual(APIError.serverError("Test").errorDescription, "Server Error: Test")
    }
}
