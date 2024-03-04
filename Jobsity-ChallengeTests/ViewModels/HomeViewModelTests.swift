//
//  HomeViewModelTests.swift
//  Jobsity-ChallengeTests
//
//  Created by Kauê Sales on 04/03/24.
//

import Foundation
import Combine
import XCTest

@testable import Jobsity_Challenge

final class HomeViewModelTests: XCTestCase {
    private var cancellables: Set<AnyCancellable> = []
    private var interactorMock: TVMazeInteractorMock!
    private var sut: HomeViewModel!

    override func setUp() {
        super.setUp()
        interactorMock = .init()
        sut = HomeViewModel(interactor: interactorMock)
    }

    override func tearDown() {
        cancellables.removeAll()
        interactorMock = nil
        sut = nil
        super.tearDown()
    }

    func test_requestShowList_withValidPage_shouldReturnExpectedData() {
        let exampleShow: ShowDetailsModel = JSONReader.load("ShowDetailsMock")
        interactorMock.showList = [exampleShow]

        sut.requestShowList(page: 1)

        XCTAssertEqual(sut.list.count, 1)
        XCTAssertEqual(sut.list.first?.id, exampleShow.id)
        XCTAssertEqual(sut.list.first?.name, exampleShow.name)
        XCTAssertEqual(sut.list.first?.genres, exampleShow.genres)
        XCTAssertEqual(interactorMock.fetchShowListArgs, [1])
    }

    func test_requestShowList_withInvalidPage_shouldPrintError() {
        interactorMock.showListError = APIError.invalidPage

        sut.requestShowList(page: -1)

        XCTAssertEqual(sut.list.count, 0)
        XCTAssertEqual(interactorMock.fetchShowListArgs, [-1])
    }

    func test_showLookup_withValidTerm_shouldReturnExpectedData() {
        let exampleShow: ShowDetailsModel = JSONReader.load("ShowDetailsMock")
        let exampleLookup: ShowLookupModel = ShowLookupModel(show: exampleShow)
        interactorMock.showLookup = [exampleLookup]

        sut.showLookup("example")

        XCTAssertEqual(sut.searchList.count, 1)
        XCTAssertEqual(sut.searchList.first?.id, exampleShow.id)
        XCTAssertEqual(sut.searchList.first?.name, exampleShow.name)
        XCTAssertEqual(sut.searchList.first?.genres, exampleShow.genres)
        XCTAssertEqual(interactorMock.fetchShowLookupArgs, ["example"])
    }

    func test_showLookup_withInvalidTerm_shouldPrintError() {
        interactorMock.showLookupError = APIError.invalidURL

        sut.showLookup("")

        XCTAssertEqual(sut.searchList.count, 0)
        XCTAssertEqual(interactorMock.fetchShowLookupArgs, [""])
    }
}
