//
//  APIToPresentationMapperTests.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import XCTest
@testable import catapitest

class APIToPresentationMapperTests: XCTestCase {

    // MARK: - Tests
    
    func testAPICatToCatMap() {
        
        // Given
        let urlStr = "https://google.com"
        let apiCat = APICat(id: "id", url: urlStr)
        let expectedCat = Cat(id: "id", url: URL(string: urlStr))
        
        // When
        let cat = APIToPresentationMapper.map(apiCat: apiCat)
        
        // Then
        XCTAssertEqual(cat.id, expectedCat.id)
        XCTAssertEqual(cat.url, expectedCat.url)
    }
}
