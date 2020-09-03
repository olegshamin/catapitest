//
//  ListViewModel.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation
import RxSwift

class ListViewModel {
    
    // MARK: - Internal properties
    
    let cats =  PublishSubject<[Cat]>()
    let randomCat = PublishSubject<Cat?>()
    let error = PublishSubject<Error>()
    let loading = PublishSubject<Bool>()
    
    // MARK: - Private properties
    
    private let disposable = DisposeBag()
    private let catService: CatServiceProtocol
    private var page = 0
    private var receivedCats: [Cat] = []
    
    // MARK: - Init
    
    init(
        catService: CatServiceProtocol
    ) {
        self.catService = catService
    }
    
    // MARK: - ListViewModel
    
    func getCats(limit: Int = 20, page: Int) {
        loading.onNext(true)
        
        catService.getCats(limit: limit, page: page) { [weak self] result in
            
            self?.loading.onNext(false)
            
            switch result {
                
            case .success(let cats):
                self?.receivedCats += cats
                self?.cats.onNext(self?.receivedCats ?? [])
                
            case .failure(let error):
                self?.error.onNext(error)
            }
        }
    }
    
    func random() {
        randomCat.onNext(receivedCats.randomElement())
    }
}
