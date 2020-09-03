//
//  MockRequest.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation
@testable import catapitest

struct MockRequest: Request {
    
    // MARK: - Request
    
    var path: String {
        "/mockPath"
    }
    
    var parameters: [String: Any]? {
        [
            "param1": "value1",
            "param2": "value2"
        ]
    }
    
    var method: RequestMethod {
        .post
    }
    
    var headers: [String : String] {
        [
            "header1": "value1",
            "header2": "value2"
        ]
    }
    
    var body: Data? {
        "mockData".data(using: .utf8)
    }
}
