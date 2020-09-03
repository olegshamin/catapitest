//
//  ListViewController.swift
//  catapitest
//
//  Created by Oleg Shamin on 01.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import UIKit
import RxSwift

class ListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Private properties
    
    private var viewModel: ListViewModel!
    private var collectionViewHandler: ListCollectionViewHandler!
    private let disposeBag = DisposeBag()
    private var page = 0
    private var needToShowRandom = false
    
    // MARK: - Init
    
    static func create(
        viewModel: ListViewModel,
        collectionViewHandler: ListCollectionViewHandler
    ) -> ListViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController else {
            fatalError("Can not initialize ListViewController")
        }
        
        viewController.viewModel = viewModel
        viewController.collectionViewHandler = collectionViewHandler
        
        return viewController
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupBindings()
        viewModel.getCats(page: page)
    }
    
    // MARK: - Internal helpers
    
    func showRandomImage() {
        needToShowRandom = true
        viewModel.random()
    }
    
    // MARK: - Private helpers
    
    private func setupCollectionView() {
        collectionViewHandler.setup(withCollectionView: collectionView, delegate: self)
    }
    
    // MARK: - Bindings
    
    private func setupBindings() {
        
        viewModel.loading
            .take(2)
            .bind(to: rx.isAnimating).disposed(by: disposeBag)
        
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.display(error: error)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .cats
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] cats in
                self?.collectionViewHandler.add(cats)
                
                if self?.needToShowRandom == true {
                    self?.showRandomImage()
                    self?.needToShowRandom = false
                }
                
            })
            .disposed(by: disposeBag)
        
        viewModel
            .randomCat
            .subscribe(onNext: { [weak self] cat in
                guard let cat = cat else {
                    return
                }
                self?.didSelectCat(cat)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - ListCollectionViewHandlerProtocol

extension ListViewController: ListCollectionViewHandlerProtocol {
    
    func lastCellDidVisible() {
        page += 1
        viewModel.getCats(page: page)
    }
    
    func didSelectCat(_ cat: Cat) {
        let vc = ViewControllerFactory.makeImage(cat: cat)
        navigationController?.pushViewController(vc, animated: true)
    }
}

