//
//  TVMazeEndpointsTests.swift
//  Jobsity-ChallengeTests
//
//  Created by Kauê Sales on 03/03/24.
//

import XCTest

@testable import Jobsity_Challenge

final class TVMazeEndpointsTests: XCTestCase {

    func test_EndpointPaths_shouldReturnExpectedPaht() {
        XCTAssertEqual(TVMazeEndpoints.shows.path, "/shows")
        XCTAssertEqual(TVMazeEndpoints.showDetails(showId: 123).path, "/shows/123")
    }

    func test_endpointURLs_shouldReturnExpectedURLs() {
        XCTAssertEqual(TVMazeEndpoints.shows.url, URL(string: "https://api.tvmaze.com/shows"))
        XCTAssertEqual(TVMazeEndpoints.showDetails(showId: 123).url, URL(string: "https://api.tvmaze.com/shows/123"))
    }

}
