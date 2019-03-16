//
//  InsetExecutor.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 16/03/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

internal class InsetExecutor {
    
    init(view: UIScrollView, calculator: InsetCalculator) {
        
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
    }
    
    func execute() {
        
    }
}
