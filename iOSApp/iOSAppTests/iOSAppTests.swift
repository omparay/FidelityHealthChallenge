//
//  iOSAppTests.swift
//  iOSAppTests
//
//  Created by Oliver Paray on 1/23/21.
//

import XCTest
import AppFramework
@testable import iOSApp

class iOSAppTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let expectation = XCTestExpectation(description: "Getting data...")
        let service = Service(endPoint: "api.jikan.moe/v3/search/anime",
                              transportProtocol: "https://",
                              queryStringFormat: "?q=%@")
        service.search(text: "Godannar") { (result) in
            switch result {
            case .success(let resultData):
                XCTAssertNotEqual(resultData.results.count, 0, "No results...")
                debugPrint("Results:",resultData)
                expectation.fulfill()
            case .failure(let error):
                debugPrint(error)
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5)
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
