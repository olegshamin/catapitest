//
//  MockCatNetworkRepository.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation
@testable import catapitest

class MockCatNetworkRepository: CatNetworkRepositoryProtocol {
    
    // MARK: - Public properties
    
    var isSuccess = true
    
    // MARK: - CatNetworkRepositoryProtocol
    
    func getCats(request: CatsListRequest, completion: @escaping ResultHandler<[APICat]>) {
        if isSuccess {
            completion(.success([APICat.mockCat1, APICat.mockCat2, APICat.mockCat3]))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
    
    func getFullImage(request: CatImageRequest, completion: @escaping ResultHandler<String>) {
        if isSuccess {
            completion(.success("https://google.com"))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
}
