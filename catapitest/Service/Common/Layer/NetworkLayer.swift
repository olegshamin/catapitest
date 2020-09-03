//
//  NetworkLayer.swift
//  catapitest
//
//  Created by Oleg Shamin on 01.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation

protocol NetworkLayerProtocol {
    func perform(request: Request, completion: @escaping NetworkResultHandler)
}

class NetworkLayer: NetworkLayerProtocol {
    
    // MARK: - Private properties
    
    private let decoder = JSONDecoder()
    
    // MARK: - NetworkLayerProtocol
    
    func perform(request: Request, completion: @escaping NetworkResultHandler) {
        
        do {
            let urlRequest = try request.asURLRequest()
            URLSession.shared.dataTask(with: urlRequest) {
                [weak self] data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                let networkResponse = NetworkResponse(data: data, response: response)
                self?.handle(networkResponse: networkResponse, completion: completion)
                
            }.resume()
            
        } catch {
            completion(.failure(error))
        }
    }
    
    // MARK: - Private helpers
    
    private func handle(
        networkResponse: NetworkResponse,
        completion: @escaping NetworkResultHandler
    ) {
        
        let statusCode = networkResponse.response.statusCode
        
        switch statusCode {
        case 200..<300:
            completion(.success(networkResponse.data))
        case 400..<500:
            handleAPIError(data: networkResponse.data, completion: completion)
        case 500..<600:
            completion(.failure(NetworkError.internalServerError))
        default:
            break
        }
    }

    // MARK: - Error Handlers
    
    private func handleAPIError(data: Data, completion: @escaping NetworkResultHandler) {
        do {
            let apiError = try decoder.decode(APIError.self, from: data)
            completion(.failure(apiError))
        } catch {
            completion(.failure(error))
        }
    }
}
