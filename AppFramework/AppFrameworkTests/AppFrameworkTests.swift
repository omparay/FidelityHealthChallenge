//
//  AppFrameworkTests.swift
//  AppFrameworkTests
//
//  Created by Oliver Paray on 1/23/21.
//

import XCTest
@testable import AppFramework

class AppFrameworkTests: XCTestCase {
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testClient() throws {
        let expectation = XCTestExpectation(description: "Getting data...")
        HTTPClient.sharedInstance.request(urlString: "https://api.jikan.moe/v3/search/anime?q=overlord",
                                          method: Method.Get) { (result) in
            switch result{
            case .success(let data):
                if let dataString = String(data: data, encoding: .utf8) {
                    XCTAssertNotEqual(dataString, String(), "Empty data")
                    debugPrint("Data:",dataString)
                } else {
                    XCTFail("No data received")
                }
                expectation.fulfill()
            case .failure(let error):
                debugPrint(error.localizedDescription)
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testPerformanceExample() throws {
        self.measure {
        }
    }

}
