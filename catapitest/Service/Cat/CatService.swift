//
//  CatService.swift
//  catapitest
//
//  Created by Oleg Shamin on 01.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import UIKit

protocol CatServiceProtocol: Service {
    func getCats(limit: Int, page: Int, completion: @escaping ResultHandler<[Cat]>)
    func getFullImageUrl(with id: String, completion: @escaping ResultHandler<URL>)
}

class CatService: CatServiceProtocol {
    
    // MARK: - Properties
    
    private let networkRepository: CatNetworkRepositoryProtocol
    
    // MARK: - Initialization
    
    required init(
        networkRepository: CatNetworkRepositoryProtocol
    ) {
        self.networkRepository = networkRepository
    }
    
    // MARK: - CatServiceProtocol
    
    /// Download list of cats from the server
    ///
    /// - Parameter limit: Number of cats on one page
    /// - Parameter page: Current page number
    /// - Parameter completion: Completion which is called when array was downloaded
    func getCats(limit: Int, page: Int, completion: @escaping ResultHandler<[Cat]>) {
        
        let request = CatsListRequest(limit: limit, page: page)
        
        networkRepository.getCats(request: request) { [weak self] result in
            self?.handle(apiCatsResult: result, completion: completion)
        }
    }
    
    /// Get the full image URL for the required cat
    ///
    /// - Parameter id: Cat id
    /// - Parameter completion: Completion which is called when URL was received
    func getFullImageUrl(with id: String, completion: @escaping ResultHandler<URL>) {
        
        let request = CatImageRequest(id: id)
        
        networkRepository.getFullImage(request: request) { [weak self] result in
            self?.handle(apiCatImageResult: result, completion: completion)
        }
    }
    
    // MARK: - Private helper
    
    private func handle(
        apiCatsResult result: Result<[APICat]>,
        completion: @escaping ResultHandler<[Cat]>
    ) {
       
        switch result {
        case .success(let apiCats):

            let cats = apiCats.map({ Cat(id: $0.id, url: URL(string: $0.url)) })
            handle(success: cats, completion: completion)
            
        case .failure(let error):
            handle(error: error, completion: completion)
        }
    }
    
    private func handle(
        apiCatImageResult result: Result<String>,
        completion: @escaping ResultHandler<URL>
    ) {
       
        switch result {
        case .success(let urlString):

            guard let url = URL(string: urlString) else {
                handle(error: NetworkError.invalidResponse, completion: completion)
                return
            }
            handle(success: url, completion: completion)
            
        case .failure(let error):
            handle(error: error, completion: completion)
        }
    }
}
