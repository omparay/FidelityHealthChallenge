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
                debugPrint(error)
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 30.0)
    }
    
    func testDecoding() throws {
        let expectation = XCTestExpectation(description: "Getting data...")
        HTTPClient.sharedInstance.request(urlString: "https://api.jikan.moe/v3/search/anime?q=overlord",
                                          method: Method.Get) { (result) in
            switch result{
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    decoder.dateDecodingStrategy = .iso8601
                    let decoded = try decoder.decode(SearchResults.self, from: data)
                    debugPrint("Data:",decoded)
                    XCTAssertNotEqual(decoded.results.count, 0, "No results...")
                    expectation.fulfill()
                } catch {
                    debugPrint(error)
                    XCTFail(error.localizedDescription)
                    expectation.fulfill()
                }
                expectation.fulfill()
            case .failure(let error):
                debugPrint(error)
                XCTFail(error.localizedDescription)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 30.0)
    }

    func testSearchService(){
        let expectation = XCTestExpectation(description: "Getting data...")
        let service = Service(endPoint: "api.jikan.moe/v3/search/anime",
                              transportProtocol: "https://",
                              queryStringFormat: "?q=%@")
        service.search(text: "Mazinger") { (result) in
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
        wait(for: [expectation], timeout: 30.0)
    }
//    func testPerformanceExample() throws {
//        self.measure {
//        }
//    }

}
