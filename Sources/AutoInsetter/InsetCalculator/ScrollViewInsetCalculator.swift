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
        return nil
    }
    
    override func calculateContentOffset(from spec: AutoInsetSpec) -> CGPoint? {
        return nil
    }
    
    override func calculateScrollIndicatorInsets(from spec: AutoInsetSpec) -> UIEdgeInsets? {
        return nil
    }
}
