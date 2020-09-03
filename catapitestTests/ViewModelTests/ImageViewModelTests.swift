//
//  ImageViewModelTests.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import XCTest
import RxSwift
@testable import catapitest

class ImageViewModelTests: XCTestCase {

    // MARK: - Private properties
    
    private var catService = MockCatService()
    private var cat = Cat(id: "id", url: URL(string: "https://google.com"))
    private var sut: ImageViewModel!
    private var disposeBag = DisposeBag()
    
    // MARK: - Life cycle

    override func setUpWithError() throws {
        sut = ImageViewModel(cat: cat, catService: catService)
    }

    // MARK: - Tests

    func testRequestImageUrlOnNextSuccessfull() {
        
        // Given
        catService.isSuccess = true
        let expectation = self.expectation(description: "expect image url")
        
        // When
        sut.catImageUrl.subscribe(onNext: { url in
            
            // Then
            XCTAssertEqual(self.cat.url, url)
            expectation.fulfill()
            
        }).disposed(by: disposeBag)
        sut.requestImage()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testRequestImageUrlFailed() {
        
        // Given
        catService.isSuccess = false
        let expectation = self.expectation(description: "expect error")
        
        // When
        
        sut.error.subscribe(onNext: { _ in
            
            // Then
            expectation.fulfill()
            
        }).disposed(by: disposeBag)
        sut.requestImage()
        
        wait(for: [expectation], timeout: 0.1)
    }
}
