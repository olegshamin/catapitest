//
//  CatImageRequest.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation

struct CatImageRequest: Request {
    
    // MARK: - Properties
    
    let id: String
    
    // MARK: - Request
    
    var path: String {
        "/images/\(id)"
    }
    
    var parameters: [String: Any]? {
        [
            ServerField.size: Size.full.rawValue
        ]
    }
}
