//
//  CatCollectionViewCell.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import UIKit

class CatCollectionViewCell: UICollectionViewCell, NibLoadable {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var catImageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicator.startAnimating()
    }
    
    // MARK: - Configure
    
    func config(with cat: Cat) {
        catImageView.loadImage(fromUrl: cat.url, completion: { [weak self] in
            self?.activityIndicator.stopAnimating()
        })
    }
}

