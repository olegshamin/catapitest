//
//  Request.swift
//  catapitest
//
//  Created by Oleg Shamin on 01.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation

/// Types adopting the `URLRequestConvertible` protocol can be used to construct URL requests.
public protocol URLRequestConvertible {
    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    func asURLRequest() throws -> URLRequest
}

/// Protocol for implementing url requests.
/// Group requests by entity types.
protocol Request: URLRequestConvertible {
    
    /// Path of resource for endpoint
    var path: String {get}
    
    /// Parameters to send
    var parameters: [String: Any]? {get}
    
    /// HTTP method of request
    var method: RequestMethod {get}
    
    /// Headers that will be added to request
    var headers: [String: String] {get}
    
    /// Request body
    var body: Data? { get }
}

// MARK: - Default values

extension Request {

    var parameters: [String: Any]? {
        return nil
    }

    var method: RequestMethod {
        return .get
    }

    var headers: [String: String] {
        return [:]
    }
    
    var body: Data? {
        return nil
    }
}

// MARK: - URLRequestConvertible

extension Request {
    
    func asURLRequest() throws -> URLRequest {
        
        let urlString = Constants.baseUrl + path
        var urlComponents = try urlString.asURL()
        
        // Add parameters to url
        var items: [URLQueryItem] = []
        for (key,value) in parameters ?? [:] {
            items.append(URLQueryItem(name: key, value: "\(value)"))
        }
        urlComponents.queryItems = items
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL(url: urlString)
        }
        
        // Setup URLRequest
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        request.addValue(Constants.apiKey, forHTTPHeaderField: ServerField.apiKey)
        
        request.httpBody = body
        
        return request
    }
}
