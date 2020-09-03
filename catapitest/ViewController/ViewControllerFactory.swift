//
//  ViewControllerFactory.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import Foundation

class ViewControllerFactory {
    
    static func makeList() -> ListViewController {
        let viewModel = ListViewModel(catService: ServiceFactory.shared.catService)
        let vc = ListViewController.create(
            viewModel: viewModel,
            collectionViewHandler: ListCollectionViewHandler()
        )
        return vc
    }
    
    static func makeImage(cat: Cat) -> ImageViewController {
        let viewModel = ImageViewModel(cat: cat, catService: ServiceFactory.shared.catService)
        let vc = ImageViewController.create(viewModel: viewModel)
        return vc
    }
}
