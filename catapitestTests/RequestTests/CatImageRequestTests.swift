//
//  CatImageRequestTests.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import XCTest
@testable import catapitest

class CatImageRequestTests: XCTestCase {

    // MARK: - Tests
    
    func testCatImageRequest() {
        
        // Given
        let request = CatImageRequest(id: "id")
        let expectedParams: [String: Any]? = [ServerField.size: Size.full.rawValue]
        
        // When
        // Then
        XCTAssertEqual(request.path, "/images/id")
        XCTAssertEqual(request.parameters?.count, 1)
        for key in (expectedParams?.keys)! {
            XCTAssertEqual("\(request.parameters?[key] ?? "")", "\(expectedParams?[key] ?? "")")
        }
    }

}
