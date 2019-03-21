//
//  ScrollViewInsetCalculator.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 16/03/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

class ScrollViewInsetCalculator: ViewInsetCalculator<UIScrollView> {
    
    override func calculateContentInset(from spec: AutoInsetSpec, store: InsetStore) -> ContentInsetCalculation? {
        let previous = store.contentInset(for: view) ?? .zero
        
        let contentInset = makeContentAndScrollIndicatorInsets(from: spec)
        guard contentInset != view.contentInset else {
            return nil
        }
        store.store(contentInset: contentInset, for: view)
        
        let customContentInset = applyCustomContentInset(to: contentInset, from: previous)
        return ContentInsetCalculation(new: customContentInset,
                                       previous: previous,
                                       currentActual: view.contentInset)
    }
    
    override func calculateContentOffset(from insetCalculation: ContentInsetCalculation, store: InsetStore) -> CGPoint? {
        guard insetCalculation.currentActual.top != insetCalculation.new.top else {
            return nil
        }
        let topInsetDelta = insetCalculation.new.top - insetCalculation.currentActual.top
        
        var contentOffset = store.contentOffset(for: view) ?? .zero
        
        var userOffsetDelta = view.contentOffset.y - contentOffset.y
        if userOffsetDelta > 0 {
            userOffsetDelta += contentOffset.y + insetCalculation.new.top
        }
        
        contentOffset.y -= topInsetDelta
        store.store(contentOffset: contentOffset, for: view)
        
        if userOffsetDelta > 0 {
            contentOffset.y += userOffsetDelta
        }
        
        return contentOffset
    }
    
    override func calculateScrollIndicatorInsets(from spec: AutoInsetSpec) -> UIEdgeInsets? {
        let scrollIndicatorInsets = makeContentAndScrollIndicatorInsets(from: spec)
        guard scrollIndicatorInsets != view.scrollIndicatorInsets else {
            return nil
        }
        return scrollIndicatorInsets
    }
    
    // MARK: Calculations
    
    private func makeContentAndScrollIndicatorInsets(from spec: AutoInsetSpec) -> UIEdgeInsets {
        let allRequiredInsets = spec.allRequiredInsets
        
        let relativeFrame = viewController.view.convert(view.frame, from: view.superview)
        
        // top
        let topInset = max(allRequiredInsets.top - relativeFrame.minY, 0.0)
        
        // left
        let leftInset = max(allRequiredInsets.left - relativeFrame.minX, 0.0)
        
        // right
        let rightInsetMinX = viewController.view.bounds.width - allRequiredInsets.right
        let rightInset = abs(min(rightInsetMinX - relativeFrame.maxX, 0.0))
        
        // bottom
        let bottomInsetMinY = viewController.view.bounds.height - allRequiredInsets.bottom
        let bottomInset = abs(min(bottomInsetMinY - relativeFrame.maxY, 0.0))
        
        return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    }
    
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
