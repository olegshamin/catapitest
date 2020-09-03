//
//  BaseViewController.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - Views
    
    private let spinner = UIActivityIndicatorView()
    private let spinnerView = UIView()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSpinnerView()
    }
    
    // MARK: - Internal helpers
    
    func displayLoading() {
        view.bringSubviewToFront(spinnerView)
        spinnerView.bringSubviewToFront(spinner)
        spinnerView.isHidden = false
        spinner.startAnimating()
    }
    
    func displayContent() {
        spinnerView.isHidden = true
        spinner.stopAnimating()
    }
    
    // MARK: - Private helpers
    
    private func setupSpinnerView() {
        spinnerView.addSubview(spinner)
        view.addSubview(spinnerView)
        spinner.hidesWhenStopped = true
        spinner.color = .black
        spinnerView.backgroundColor = .white
        spinnerView.isHidden = true
        spinnerView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            spinnerView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            spinnerView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            spinnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        spinner.alignCentered(in: spinnerView)
    }
}
