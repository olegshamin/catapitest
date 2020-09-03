//
//  ListCollectionViewHandler.swift
//  catapitest
//
//  Created by Oleg Shamin on 01.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol ListCollectionViewHandlerProtocol: class {
    func didSelectCat(_ cat: Cat)
    func lastCellDidVisible()
}

class ListCollectionViewHandler: NSObject {
    
    // MARK: - Public properties
    
    weak var delegate: ListCollectionViewHandlerProtocol?
    
    // MARK: - Private properties
    
    private let layout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = .zero
        layout.scrollDirection = .vertical
        return layout
    }()
    private let disposeBag = DisposeBag()
    private var cats = BehaviorRelay<[Cat]>(value: [])

    // MARK: - Setup
    
    func setup(
        withCollectionView collectionView: UICollectionView,
        delegate: ListCollectionViewHandlerProtocol?
    ) {
        
        self.delegate = delegate
        
        collectionView.backgroundColor = .white
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.delegate = self
        collectionView.register(CatCollectionViewCell.self)
        
        let loadingReusableNib = UINib(nibName: "CollectionLoadingView", bundle: nil)
        collectionView.register(loadingReusableNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CollectionLoadingView")
        
        setupBinding(collectionView: collectionView)
    }
    
    func add(_ items: [Cat]) {
        cats.accept(cats.value + items)
    }
    
    // MARK: - Binding
    
    private func setupBinding(collectionView: UICollectionView) {
        
        cats.bind(to: collectionView.rx
            .items(cellIdentifier: "CatCollectionViewCell", cellType: CatCollectionViewCell.self)) {  (row, cat, cell) in
                cell.config(with: cat)
                
        }.disposed(by: disposeBag)

        collectionView
            .rx.willDisplayCell
            .subscribe(onNext: ({ [weak self] (cell, indexPath) in
                
                let count = collectionView.numberOfItems(inSection: 0)
                if indexPath.row >= count - 1 {
                    self?.delegate?.lastCellDidVisible()
                }
            })
        ).disposed(by: disposeBag)
        
        collectionView
            .rx.modelSelected(Cat.self)
            .subscribe(onNext: { [weak self] cat in
                self?.delegate?.didSelectCat(cat)
                }
        ).disposed(by: disposeBag)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ListCollectionViewHandler: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        
        let width = (collectionView.frame.width - layout.minimumInteritemSpacing) / 2
        return CGSize(width: width, height: width)
    }
}
