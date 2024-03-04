//
//  Jobsity_ChallengeTests.swift
//  Jobsity-ChallengeTests
//
//  Created by Kauê Sales on 03/03/24.
//

import XCTest

@testable import Jobsity_Challenge

final class URLExtensionTests: XCTestCase {
    func test_appendingQueryItem_shouldAddExpectedQueryParameters() {
        let base = URL(string: "http://dummyurl.com")!
        
        let url = base.appendingQueryItem(name: "dummyKey", value: "dummyValue")
        
        XCTAssertEqual(url?.absoluteString, "http://dummyurl.com?dummyKey=dummyValue")
    }
}
