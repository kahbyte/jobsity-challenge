//
//  TVMazeInteractorTests.swift
//  Jobsity-ChallengeTests
//
//  Created by Kauê Sales on 04/03/24.
//

import XCTest
import Combine
@testable import Jobsity_Challenge

final class TVMazeInteractorTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    private var requestMock: RequestMock!
    private var sut: TVMazeInteractor!
    
    override func setUp() {
        super.setUp()
        requestMock = .init()
        sut = .init(apiClient: requestMock)
    }
    
    override func tearDown() {
        cancellables.removeAll()
        requestMock = nil
        sut = nil
        super.tearDown()
    }
    
    func test_fetchShowList_withValidConfiguration_shouldReturnExpectedData() {
        let expectation = XCTestExpectation(description: "Fetch show list")
        
        let url = URL(string: "dummyURL")
        let dummyShow: ShowDetailsModel = JSONReader.load("ShowDetailsMock")
        let dummyShowData = try! JSONEncoder().encode([dummyShow])
        requestMock.dataMock = dummyShowData
        
        sut.fetchShowList(page: 1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Fetch failed with error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { shows in
                XCTAssertEqual(shows.count, 1)
                XCTAssertEqual(shows.first?.id, dummyShow.id)
                XCTAssertEqual(shows.first?.name, dummyShow.name)
                XCTAssertEqual(shows.first?.genres, dummyShow.genres)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
        requestMock.verifyFetchWasCalledOnce()
    }
    
    func test_fetchShowList_ifPageIsLessThanOne_shouldReturnInvalidPageError() {
        let expectation = XCTestExpectation(description: "Fetch show list with invalid page")

        requestMock.errorMock = APIError.invalidPage

        sut.fetchShowList(page: -1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error as? APIError, APIError.invalidPage)
                    expectation.fulfill()
                case .finished:
                    XCTFail("Fetch should not complete successfully")
                }
            }, receiveValue: { _ in
                XCTFail("Fetch should not return a value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10.0)
        
        requestMock.verifyFetchWasNeverCalled()
    }

    func test_fetchShowDetails_withValidConfiguration_shouldReturnExpectedData() {
        let expectation = XCTestExpectation(description: "Fetch show details")
        
        let showId = 1
        let dummyShow: ShowDetailsModel = JSONReader.load("ShowDetailsMock")
        let dummyShowData = try! JSONEncoder().encode(dummyShow)
        requestMock.dataMock = dummyShowData
        
        sut.fetchShowDetails(showId: showId)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Fetch failed with error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { show in
                XCTAssertEqual(show.id, dummyShow.id)
                XCTAssertEqual(show.name, dummyShow.name)
                XCTAssertEqual(show.genres, dummyShow.genres)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 10.0)
        requestMock.verifyFetchWasCalledOnce()
    }

    func test_fetchShowDetails_withInvalidShowId_shouldReturnInvalidURLError() {
        let expectation = XCTestExpectation(description: "Fetch show details with invalid showId")

        requestMock.errorMock = APIError.invalidURL

        sut.fetchShowDetails(showId: -1)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error as? APIError, APIError.invalidURL)
                    expectation.fulfill()
                case .finished:
                    XCTFail("Fetch should not complete successfully")
                }
            }, receiveValue: { _ in
                XCTFail("Fetch should not return a value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10.0)
    }

    func test_fetchShowLookup_withEmptyTerm_shouldReturnInvalidURLError() {
        let expectation = XCTestExpectation(description: "Fetch show lookup with empty term")

        requestMock.errorMock = APIError.invalidURL

        sut.fetchShowLookup("")
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error as? APIError, APIError.invalidURL)
                    expectation.fulfill()
                case .finished:
                    XCTFail("Fetch should not complete successfully")
                }
            }, receiveValue: { _ in
                XCTFail("Fetch should not return a value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 10.0)
    }

}
