//
//  Result.swift
//  catapitest
//
//  Created by Oleg Shamin on 01.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

typealias ResultHandler<T> = (Result<T>) -> Void
typealias NetworkResultHandler = (Result<Data>) -> Void
typealias VoidResult = Result<Void>
typealias VoidResultHandler = (VoidResult) -> Void

extension Result {
    
    init(attempt block: () throws -> T) {
        do {
            self = .success(try block())
        } catch {
            self = .failure(error)
        }
    }
}
