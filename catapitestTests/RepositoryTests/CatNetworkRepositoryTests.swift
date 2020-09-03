//
//  CatNetworkRepositoryTests.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import XCTest
@testable import catapitest

class CatNetworkRepositoryTests: XCTestCase {

    // MARK: - Private properties
    
    private var sut: CatNetworkRepositoryProtocol!
    private var networkLayer = MockNetworkLayer()

    override func setUpWithError() throws {
        sut = CatNetworkRepository(networkLayer: networkLayer)
    }

    // MARK: - Tests

    func testGetCatsSuccessCompletionCalled() {
        // Given
        let expectation = self.expectation(description: "Completion expectation")

        // When
        sut.getCats(request: CatsListRequest(limit: 20, page: 0)) { _ in
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetCatsFailedCompletionCalled() {
        // Given
        let expectation = self.expectation(description: "Completion expectation")

        // When
        networkLayer.isSuccess = false
        sut.getCats(request: CatsListRequest(limit: 20, page: 0)) { _ in
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetFullImageSuccessCompletionCalled() {
        // Given
        let expectation = self.expectation(description: "Completion expectation")

        // When
        sut.getFullImage(request: CatImageRequest(id: "")) { _ in
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetFullImageFailedCompletionCalled() {
        // Given
        let expectation = self.expectation(description: "Completion expectation")

        // When
        networkLayer.isSuccess = false
        sut.getFullImage(request: CatImageRequest(id: "")) { _ in
            expectation.fulfill()
        }
        
        // Then
        wait(for: [expectation], timeout: 1)
    }
}
