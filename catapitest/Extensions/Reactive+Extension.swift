//
//  Reactive+Extension.swift
//  catapitest
//
//  Created by Oleg Shamin on 03.09.2020.
//  Copyright © 2020 Oleg Shamin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: BaseViewController {
    
    /// Bindable sink for `displayLoading()`, `displayContent()` methods.
    var isAnimating: Binder<Bool> {
        return Binder(base, binding: { (vc, active) in
            if active {
                vc.displayLoading()
            } else {
                vc.displayContent()
            }
        })
    }
}
