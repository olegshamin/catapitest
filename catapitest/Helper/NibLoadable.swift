//
//  NibLoadable.swift
//  catapitest
//
//  Created by Oleg Shamin on 02.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import UIKit

// Protocol for loading views from Nibs.
// Nib name should be the same as class name for this protocol to work.
protocol NibLoadable: class {}

extension NibLoadable where Self: UIView {
    static var nibName: String {
        return String(describing: Self.self)
    }
}
