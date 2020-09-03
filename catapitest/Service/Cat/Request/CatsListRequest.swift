//
//  CatsListRequest.swift
//  catapitest
//
//  Created by Oleg Shamin on 01.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation

struct CatsListRequest: Request {
    
    // MARK: - Properties
    
    let limit: Int
    let page: Int
    
    // MARK: - Request
    
    var path: String {
        "/images/search"
    }
    
    var parameters: [String: Any]? {
        [
            ServerField.size: Size.thumb.rawValue,
            ServerField.order: Order.asc.rawValue,
            ServerField.page: page,
            ServerField.limit: limit
        ]
    }
}
