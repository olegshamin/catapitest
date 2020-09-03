//
//  CatServiceTests.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import XCTest
@testable import catapitest

class CatServiceTests: XCTestCase {

    // MARK: - Private properties
    
    private var sut: CatServiceProtocol!
    private var networkRepository = MockCatNetworkRepository()
    
    // MARK: - Life cycle

    override func setUpWithError() throws {
        sut = CatService(networkRepository: networkRepository)
    }
    
    // MARK: - Tests

    func testGetCatsSuccessfully() {
        
        // Given
        let expectation = self.expectation(description: "Service expectation")
        
        // When
        networkRepository.isSuccess = true
        sut.getCats(limit: 0, page: 0) { result in
            guard case .success = result else {
                XCTFail("Wrong result case: \(result)")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetCatsFailed() {
        
        // Given
        let expectation = self.expectation(description: "Service expectation")
        
        // When
        networkRepository.isSuccess = false
        sut.getCats(limit: 0, page: 0) { result in
            guard case .failure = result else {
                XCTFail("Wrong result case: \(result)")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetFullImageSuccessfully() {
        
        // Given
        let expectation = self.expectation(description: "Service expectation")
        
        // When
        networkRepository.isSuccess = true
        sut.getFullImageUrl(with: "") { result in
            guard case .success = result else {
                XCTFail("Wrong result case: \(result)")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetFullImageFailed() {
        
        // Given
        let expectation = self.expectation(description: "Service expectation")
        
        // When
        networkRepository.isSuccess = false
        sut.getFullImageUrl(with: "") { result in
            guard case .failure = result else {
                XCTFail("Wrong result case: \(result)")
                return
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1)
    }
}
