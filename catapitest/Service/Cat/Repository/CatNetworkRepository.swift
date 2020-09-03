//
//  CatNetworkRepository.swift
//  catapitest
//
//  Created by Oleg Shamin on 01.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation

protocol CatNetworkRepositoryProtocol {
    func getCats(request: CatsListRequest, completion: @escaping ResultHandler<[APICat]>)
    func getFullImage(request: CatImageRequest, completion: @escaping ResultHandler<String>)
}

class CatNetworkRepository: CatNetworkRepositoryProtocol {
    
    // MARK: - Private properties
    
    private let networkLayer: NetworkLayerProtocol
    private let decoder = JSONDecoder()
    
    // MARK: - Initialization
    
    required init(
        networkLayer: NetworkLayerProtocol = NetworkLayer()
    ) {
        self.networkLayer = networkLayer
    }
    
    // MARK: - CatNetworkRepositoryProtocol
    
    func getCats(request: CatsListRequest, completion: @escaping ResultHandler<[APICat]>) {
        networkLayer.perform(request: request) { [weak self] result in
            self?.handle(catsResult: result, completion: completion)
        }
    }
    
    func getFullImage(request: CatImageRequest, completion: @escaping ResultHandler<String>) {
        networkLayer.perform(request: request) { [weak self] result in
            self?.handle(catImageResult: result, completion: completion)
        }
    }
    
    // MARK: - Private helpers
    
    private func handle(
        catsResult result: Result<Data>,
        completion: @escaping ResultHandler<[APICat]>
        ) {
        switch result {
        case .success(let data):
            
            let result = Result(attempt: { try parseCats(data: data) })
            completion(result)
            
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    private func handle(
        catImageResult result: Result<Data>,
        completion: @escaping ResultHandler<String>
        ) {
        switch result {
        case .success(let data):
            
            let result = Result(attempt: { try parseCatUrl(data: data) })
            completion(result)
            
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    // MARK: - Parsing helpers
    
    private func parseCats(
        data: Data
    ) throws -> [APICat] {
        try decoder.decode([APICat].self, from: data)
    }
    
    private func parseCatUrl(
        data: Data
    ) throws -> String {
        let cat = try decoder.decode(APICat.self, from: data)
        return cat.url
    }
}
