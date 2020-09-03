//
//  APIToPresentationMapper.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation

class APIToPresentationMapper {
    
    // MARK: - Cat
    
    static func map(apiCat: APICat) -> Cat {
        let cat = Cat(id: apiCat.id, url: URL(string: apiCat.url))
        return cat
    }
}
