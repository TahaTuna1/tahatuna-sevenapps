//
//  NetworkTest.swift
//  sevenapps-caseTests
//
//  Created by Taha Tuna on 13.03.2025.
//

import XCTest
@testable import sevenapps_case

// Example Network Test
final class NetworkTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        URLProtocol.registerClass(MockURLProtocol.self)
    }
    
    override func tearDown() {
        URLProtocol.unregisterClass(MockURLProtocol.self)
        MockURLProtocol.testData = nil
        MockURLProtocol.responseError = nil
        super.tearDown()
    }
    
    
    func testFetchUsersSuccess() {
        // Mock Data
        let mockJSON = """
            [
                {
                    "id": 1,
                    "name": "Taha Tuna",
                    "username": "tahatuna42",
                    "email": "ios@tahatuna.com",
                    "address": {
                        "street": "street name",
                        "suite": "1",
                        "city": "Istanbul",
                        "zipcode": "12345",
                        "geo": {
                            "lat": "0.0",
                            "lng": "0.0"
                        }
                    },
                    "phone": "123-456-7890",
                    "website": "tahatuna.com",
                    "company": {
                        "name": "SevenApps",
                        "catchPhrase": "Apps & Stuff",
                        "bs": "business stuff"
                    }
                }
            ]
        """.data(using: .utf8)!
        
        MockURLProtocol.testData = mockJSON
        let expectation = self.expectation(description: "FetchUsersSuccess")
        
        NetworkService.shared.fetchUsers { result in
            switch result {
            case .success(let users):
                XCTAssertEqual(users.count, 1)
                XCTAssertEqual(users.first?.name, "Taha Tuna")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success but got failure")
            }
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testFetchUsersFailure() {
        MockURLProtocol.responseError = NSError(domain: "TestDomain", code: 1, userInfo: nil)
        let expectation = self.expectation(description: "FetchUsersFailure")
        
        NetworkService.shared.fetchUsers { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
