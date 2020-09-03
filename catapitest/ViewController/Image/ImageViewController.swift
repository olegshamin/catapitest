//
//  ImageViewController.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import UIKit
import RxSwift

class ImageViewController: BaseViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    // MARK: - Private properties
    
    private var viewModel: ImageViewModel!
    private let disposeBag = DisposeBag()
    private var imageUrl = PublishSubject<URL>()
    
    // MARK: - Init
    
    static func create(
        viewModel: ImageViewModel
    ) -> ImageViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ImageViewController") as? ImageViewController else {
            fatalError("Can not initialize ImageViewController")
        }
        
        viewController.viewModel = viewModel
        
        return viewController
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayLoading()
        setupBindings()
        viewModel.requestImage()
        
        scrollView.maximumZoomScale = 10
    }
    
    // MARK: - Binding
    
    private func setupBindings() {
        
        viewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                self?.display(error: error)
            })
            .disposed(by: disposeBag)
        
        viewModel
            .catImageUrl
            .bind(to: imageUrl)
            .disposed(by: disposeBag)
        
        imageUrl
            .subscribe(onNext: { [weak self] url in
                self?.imageView.loadImage(fromUrl: url, completion: {
                    self?.displayContent()
                })
            }).disposed(by: disposeBag)
    }
}

//MARK: - Sizing

extension ImageViewController {
    
    func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
}

//MARK: - UIScrollViewDelegate

extension ImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        updateConstraintsForSize(view.bounds.size)
    }
}
