//
//  APIError.swift
//  catapitest
//
//  Created by Oleg Shamin on 01.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation

struct APIError: Error, LocalizedError, Codable {
    
    // MARK: - Private properties
    
    let message: String
    
    // MARK: - Initialization
    
    init(
        message: String
        ) {
        self.message = message
    }
    
    // MARK: - LocalizedError
    
    var errorDescription: String? {
        return self.message
    }
}
