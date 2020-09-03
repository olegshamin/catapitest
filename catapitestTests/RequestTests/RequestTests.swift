//
//  RequestTests.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import XCTest
@testable import catapitest

class RequestTests: XCTestCase {

    // MARK: - Tests
    
    func testAsURLRequest() {
        // Given
        let request = MockRequest()
        
        // When
        guard let urlRequest = try? request.asURLRequest() else {
            XCTFail("Can not create URL request")
            return
        }
        // url with params
        let expectedURL = "/v1\(request.path)"
        
        // Then
        XCTAssertEqual(urlRequest.url?.path, expectedURL)
        XCTAssertEqual(urlRequest.httpMethod, request.method.rawValue)
        XCTAssertEqual(urlRequest.httpBody, request.body)
        for (key, value) in request.headers {
            XCTAssertEqual(urlRequest.allHTTPHeaderFields?[key], value)
        }
        XCTAssertEqual(urlRequest.allHTTPHeaderFields?[ServerField.apiKey], Constants.apiKey)
    }

}
