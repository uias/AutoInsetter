//
//  InsetExecutor.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 16/03/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

internal class InsetExecutor {
    
    let view: UIScrollView
    let calculator: InsetCalculator
    let spec: AutoInsetSpec
    
    init(view: UIScrollView, calculator: InsetCalculator, spec: AutoInsetSpec) {
        self.view = view
        self.calculator = calculator
        self.spec = spec
        
        if #available(iOS 11.0, *) {
            view.contentInsetAdjustmentBehavior = .never
        }
    }
    
    func execute(store: InsetStore) {
        
        let hasTopContentInsetChanged: Bool
        let previousContentInset = store.contentInset(for: view)
        
        // If content inset has changed
        if let contentInset = calculator.calculateContentInset(from: spec) {
            store.store(contentInset: contentInset, for: view)
            
            let contentInset = applyCustomContentInset(to: contentInset, from: previousContentInset)
            
            hasTopContentInsetChanged = contentInset.top != view.contentInset.top
            view.contentInset = contentInset
            
        } else {
            hasTopContentInsetChanged = false
        }
        
        // If content offset has changed
        if let contentOffset = calculator.calculateContentOffset(from: spec), hasTopContentInsetChanged {
            view.contentOffset = contentOffset
        }
        
        // If  indicator insets have changed.
        if let scrollIndicatorInsets = calculator.calculateScrollIndicatorInsets(from: spec) {
            view.scrollIndicatorInsets = scrollIndicatorInsets
        }
    }
    
    //  MARK: Utility
    
    private func applyCustomContentInset(to contentInset: UIEdgeInsets, from previous: UIEdgeInsets?) -> UIEdgeInsets {
        let previous = previous ?? .zero
        var contentInset = contentInset
        
        // Take into account any custom insets
        if view.contentInset.top != 0.0 {
            contentInset.top += view.contentInset.top - previous.top
        }
        if view.contentInset.left != 0.0 {
            contentInset.left += view.contentInset.left - previous.left
        }
        if view.contentInset.bottom != 0.0 {
            contentInset.bottom += view.contentInset.bottom - previous.bottom
        }
        if  view.contentInset.right != 0.0 {
            contentInset.right += view.contentInset.right - previous.right
        }
        
        return contentInset
    }
}
