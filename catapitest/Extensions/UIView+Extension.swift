//
//  UIView+Extension.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Constraints view's center to the center of provided view
    ///
    /// - Parameter view: View to which current view is aligned
    func alignCentered(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        let constraints = [
            centerXAnchor.constraint(equalTo: margins.centerXAnchor),
            centerYAnchor.constraint(equalTo: margins.centerYAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

