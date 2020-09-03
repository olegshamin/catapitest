//
//  MockCat.swift
//  catapitestTests
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation
@testable import catapitest

extension APICat {
    
    static var mockCat1: APICat {
        APICat(id: "id1", url: "https://google.com")
    }
    
    static var mockCat2: APICat {
        APICat(id: "id2", url: "https://google.ru")
    }
    
    static var mockCat3: APICat {
        APICat(id: "id3", url: "https://google.cc")
    }
}

extension Cat {
    
    static var mockCat1: Cat {
        Cat(id: "id1", url: URL(string: "https://google.com"))
    }
    
    static var mockCat2: Cat {
        Cat(id: "id2", url: URL(string: "https://google.ru"))
    }
    
    static var mockCat3: Cat {
        Cat(id: "id3", url: URL(string: "https://google.cc"))
    }
}
