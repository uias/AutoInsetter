//
//  ScrollViewInsetCalculator.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 16/03/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

class ScrollViewInsetCalculator: ViewInsetCalculator<UIScrollView> {
    
    override func calculateContentInset(from spec: AutoInsetSpec) -> UIEdgeInsets? {
        return UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0)
    }
    
    override func calculateContentOffset(from spec: AutoInsetSpec) -> CGPoint? {
        return nil
    }
    
    override func calculateScrollIndicatorInsets(from spec: AutoInsetSpec) -> UIEdgeInsets? {
        return nil
    }
}
