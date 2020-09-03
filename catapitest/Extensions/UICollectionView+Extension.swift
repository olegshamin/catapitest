//
//  UICollectionView+Extension.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import UIKit

extension UICollectionViewCell: ReusableView {}

extension UICollectionView {
    
    /// Register cell with specific type. Cell reuseIdentifier must be equal cell type and cell must implememt NibLoadable protocol
    ///
    /// - Parameter CellType: Type of the specific cell
    func register<CellType: UICollectionViewCell>(_: CellType.Type) where CellType: NibLoadable {
        let nib = UINib(nibName: CellType.nibName, bundle: Bundle(for: CellType.self))
        register(nib, forCellWithReuseIdentifier: CellType.reuseIdentifier)
    }
}
