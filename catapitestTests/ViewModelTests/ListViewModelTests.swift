//
//  ListViewModelTests.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import XCTest
import RxSwift
@testable import catapitest

class ListViewModelTests: XCTestCase {
    
    // MARK: - Private properties
    
    private var catService = MockCatService()
    private var sut: ListViewModel!
    private var disposeBag = DisposeBag()
    
    // MARK: - Life cycle

    override func setUpWithError() throws {
        sut = ListViewModel(catService: catService)
    }

    // MARK: - Tests
    
    func testGetCatsOnNextSuccessfull() {
        
        // Given
        catService.isSuccess = true
        let expectedCats = [Cat.mockCat1, Cat.mockCat2, Cat.mockCat3]
        let expectation = self.expectation(description: "getCats contain mock cats")
        
        // When
        sut.cats.subscribe(onNext: { cats in
            
            // Then
            XCTAssertEqual(cats, expectedCats)
            expectation.fulfill()
            
        }).disposed(by: disposeBag)
        sut.getCats(page: 0)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGetCatsOnNextFailed() {
        
        // Given
        catService.isSuccess = false
        let expectation = self.expectation(description: "getCats contain error")
        
        // When
        sut.error.subscribe(onNext: { _ in
            
            // Then
            expectation.fulfill()
            
        }).disposed(by: disposeBag)
        sut.getCats(page: 0)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testRandom() {
        
        // Given
        catService.isSuccess = true
        let expectation = self.expectation(description: "expect random cat")
        
        // When
        sut.getCats(page: 0)
        sut.randomCat.subscribe(onNext: { cat in
            
            // Then
            XCTAssertTrue([Cat.mockCat1, Cat.mockCat2, Cat.mockCat3].contains(cat))
            expectation.fulfill()
            
        }).disposed(by: disposeBag)
        sut.random()

        wait(for: [expectation], timeout: 0.1)
    }

}
