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
        XCTAssertEqual(TVMazeEndpoints.searchShows.path, "/search/shows")
        XCTAssertEqual(TVMazeEndpoints.personAppearances(personId: 123).path, "/people/123/castcredits")
        XCTAssertEqual(TVMazeEndpoints.episodes(showId: 123).path, "/shows/123/episodes")
        XCTAssertEqual(TVMazeEndpoints.episodeGuestAndCast(episode: 123).path, "/episodes/123/guestcast")
        XCTAssertEqual(TVMazeEndpoints.cast(showId: 123).path, "/shows/123/cast")
    }
    
    func test_endpointURLs_shouldReturnExpectedURLs() {
        XCTAssertEqual(TVMazeEndpoints.shows.url, URL(string: "https://api.tvmaze.com/shows"))
        XCTAssertEqual(TVMazeEndpoints.showDetails(showId: 123).url, URL(string: "https://api.tvmaze.com/shows/123"))
        XCTAssertEqual(TVMazeEndpoints.searchShows.url, URL(string: "https://api.tvmaze.com/search/shows"))
        XCTAssertEqual(TVMazeEndpoints.personAppearances(personId: 123).url, URL(string: "https://api.tvmaze.com/people/123/castcredits"))
        XCTAssertEqual(TVMazeEndpoints.episodes(showId: 123).url, URL(string: "https://api.tvmaze.com/shows/123/episodes"))
        XCTAssertEqual(TVMazeEndpoints.episodeGuestAndCast(episode: 123).url, URL(string: "https://api.tvmaze.com/episodes/123/guestcast"))
        XCTAssertEqual(TVMazeEndpoints.cast(showId: 123).url, URL(string: "https://api.tvmaze.com/shows/123/cast"))
    }
}
