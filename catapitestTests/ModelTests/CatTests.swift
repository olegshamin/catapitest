//
//  CatTests.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import XCTest
@testable import catapitest

class CatTests: XCTestCase {

    // MARK: - Tests
    
    func testEquality() {

        let cat1 = Cat(id: "id1", url: URL(string: "test"))
        let cat2 = Cat(id: "id1", url: URL(string: "test"))
        
        XCTAssertEqual(cat1, cat2)
    }

    func testNotEquality() {

        let cat1 = Cat(id: "id1", url: URL(string: "test"))
        let cat2 = Cat(id: "id2", url: URL(string: "test"))
        
        XCTAssertNotEqual(cat1, cat2)
    }
}
