//
//  MockNetworkLayer.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation
@testable import catapitest

class MockNetworkLayer: NetworkLayerProtocol {
    
    // MARK: - Public properties
    
    var isSuccess = true
    
    // MARK: - NetworkLayerProtocol
    
    func perform(request: Request, completion: @escaping NetworkResultHandler) {
        if isSuccess {
            completion(.success(Data()))
        } else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
}
