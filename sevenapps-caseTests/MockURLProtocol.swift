//
//  MockURLProtocol.swift
//  sevenapps-caseTests
//
//  Created by Taha Tuna on 13.03.2025.
//

import Foundation

class MockURLProtocol: URLProtocol {
    static var testData: Data?
    static var responseError: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let error = MockURLProtocol.responseError {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else if let data = MockURLProtocol.testData {
            self.client?.urlProtocol(self, didLoad: data)
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
