//
//  MockCatService.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation
@testable import catapitest

class MockCatService: CatServiceProtocol {
    
    // MARK: - Public properties
    
    var isSuccess = true
    
    // MARK: - CatServiceProtocol
    
    func getCats(limit: Int, page: Int, completion: @escaping ResultHandler<[Cat]>) {
        if isSuccess {
            completion(.success([Cat.mockCat1, Cat.mockCat2, Cat.mockCat3]))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
    
    func getFullImageUrl(with id: String, completion: @escaping ResultHandler<URL>) {
        if isSuccess {
            completion(.success(URL(string: "https://google.com")!))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
}
