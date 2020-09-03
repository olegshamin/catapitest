//
//  CatsListRequestTests.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import XCTest
@testable import catapitest

class CatsListRequestTests: XCTestCase {

    // MARK: - Tests
    
    func testCatImageRequest() {
        
        // Given
        let request = CatsListRequest(limit: 0, page: 0)
        let expectedParams: [String: Any]? = [
            ServerField.size: Size.thumb.rawValue,
            ServerField.order: Order.asc.rawValue,
            ServerField.page: 0,
            ServerField.limit: 0
        ]
        
        // When
        // Then
        XCTAssertEqual(request.path, "/images/search")
        XCTAssertEqual(request.parameters?.count, expectedParams?.count)
        for key in (expectedParams?.keys)! {
            XCTAssertEqual("\(request.parameters?[key] ?? "")", "\(expectedParams?[key] ?? "")")
        }
    }

}
