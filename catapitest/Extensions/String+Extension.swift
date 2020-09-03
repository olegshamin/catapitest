//
//  String+Extension.swift
//  catapitest
//
//  Created by Oleg Shamin on 01.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation

extension String {
    
    /// Returns a URLComponents if `self` represents a valid URL string that conforms to RFC 2396 or throws an `NetworkError`.
    ///
    /// - throws: `NetworkError.invalidURL` if `self` is not a valid URL string.
    /// - returns: A URLComponents or throws an `NetworkError`.
    func asURL() throws -> URLComponents {
        guard let url = URLComponents(string: self) else {
            throw NetworkError.invalidURL(url: self)
        }
        return url
    }
}
