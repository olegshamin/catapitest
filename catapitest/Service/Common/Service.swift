//
//  Service.swift
//  catapitest
//
//  Created by Oleg Shamin on 01.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation

// Base protocol for services
protocol Service: AnyObject {
}

/// Contains helpers for handling completion blocks to avoid code duplication
/// and so that all completion blocks are handled in one place
extension Service {
    
    func handle<T>(result: Result<T>, completion: @escaping ResultHandler<T>) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
    
    func handle<T>(error: Error, completion: @escaping ResultHandler<T>) {
        DispatchQueue.main.async {
            completion(.failure(error))
        }
    }
    
    func handle<T>(success value: T, completion: @escaping ResultHandler<T>) {
        DispatchQueue.main.async {
            completion(.success(value))
        }
    }
    
    func handle(voidResult: VoidResult, completion: @escaping VoidResultHandler) {
        DispatchQueue.main.async {
            switch voidResult {
            case .success:
                completion(.success(Void()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
