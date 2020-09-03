//
//  ServiceFactory.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation

class ServiceFactory {
    
    // MARK: - Public properties
    
    static let shared = ServiceFactory()
    let catService: CatServiceProtocol
    
    // MARK: - Initialization
    
    private init() {
        self.catService = CatService(networkRepository: CatNetworkRepository())
    }
}
