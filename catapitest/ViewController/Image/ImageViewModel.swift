//
//  ImageViewModel.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation
import RxSwift

class ImageViewModel {
    
    // MARK: - Internal properties
    
    let catImageUrl: PublishSubject<URL> = PublishSubject()
    let error : PublishSubject<Error> = PublishSubject()
    
    // MARK: - Private properties
    
    private let disposable = DisposeBag()
    private let catService: CatServiceProtocol
    private let cat: Cat
    
    // MARK: - Init
    
    init(
        cat: Cat,
        catService: CatServiceProtocol
    ) {
        self.catService = catService
        self.cat = cat
    }
    
    // MARK: - ImageViewModel
    
    func requestImage() {
        
        catService.getFullImageUrl(with: cat.id) { [weak self] result in
            
            switch result {
            case .success(let url) :
                self?.catImageUrl.onNext(url)
                
            case .failure(let error) :
                self?.error.onNext(error)
            }
        }
    }
}
