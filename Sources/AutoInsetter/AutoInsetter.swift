//
//  AutoInsetter.swift
//  AutoInset
//
//  Created by Merrick Sapsford on 16/01/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

/// Engine that provides Auto Insetting to UIViewControllers.
public final class AutoInsetter {
    
    // MARK: Properties
    
    private var currentContentInsets = [UIScrollView: UIEdgeInsets]()
    private var currentContentOffsets = [UIScrollView: CGPoint]()
    
    private let insetStore: InsetStore = DefaultInsetStore()
    
    /// Whether auto-insetting is enabled.
    @available(*, deprecated: 1.5.0, message: "Use enable(for:)")
    public var isEnabled: Bool {
        set {
            if newValue {
                _enable(for: nil)
            }
        } get {
            return _isEnabled
        }
    }
    private var _isEnabled: Bool = false
    
    // MARK: Init
    
    public init() {}
    
    // MARK: State
    
    /// Enable Auto Insetting for a view controller.
    ///
    /// - Parameter viewController: View controller that will provide insetting.
    public func enable(for viewController: UIViewController?) {
        _enable(for: viewController)
    }
    
    private func _enable(for viewController: UIViewController?) {
        _isEnabled = true
        viewController?.automaticallyAdjustsScrollViewInsets = false
    }
    
    // MARK: Insetting
    
    /// Inset a view controller by a set of required insets.
    ///
    /// - Parameters:
    ///   - viewController: view controller to inset.
    ///   - requiredInsetSpec: The required inset specification.
    public func inset(_ viewController: UIViewController?,
                      requiredInsetSpec: AutoInsetSpec) {
        guard let viewController = viewController, _isEnabled else {
            return
        }
        
        if #available(iOS 11, *) {
            if requiredInsetSpec.additionalRequiredInsets != viewController.additionalSafeAreaInsets {
                viewController.additionalSafeAreaInsets = requiredInsetSpec.additionalRequiredInsets
            }
        }
        
        guard viewController.shouldEvaluateEmbeddedScrollViews() else {
            return
        }
        viewController.forEachEmbeddedScrollView { (scrollView) in
            let calculator = self.makeInsetCalculator(for: scrollView, viewController: viewController)
            let executor = InsetExecutor(view: scrollView, calculator: calculator, spec: requiredInsetSpec)
            
            executor.execute(store: insetStore)
//            let requiredContentInset = calculateActualRequiredContentInset(for: scrollView,
//                                                                           from: requiredInsetSpec,
//                                                                           in: viewController)
//            print("requiredContentInset \(requiredContentInset)")
//
//            // dont update if we dont need to
//            if scrollView.contentInset != requiredContentInset {
//
//                let isTopInsetChanged = requiredContentInset.top != scrollView.contentInset.top
//                let topInsetDelta = requiredContentInset.top - scrollView.contentInset.top
//
//                scrollView.contentInset = requiredContentInset
//                scrollView.scrollIndicatorInsets = requiredContentInset
//
//                // only update contentOffset if the top contentInset has updated.
//                if isTopInsetChanged {
//                    var contentOffset = self.currentContentOffsets[scrollView] ?? .zero
//
//                    // Calculate the user 'delta' - the amount that the user has scrolled
//                    // the scroll view before insetting.
//                    var userDelta = scrollView.contentOffset.y - contentOffset.y
//                    if userDelta > 0 { // If offset delta exists compare to insets to ensure it is user.
//                        userDelta += contentOffset.y + scrollView.contentInset.top
//                    }
//
//                    contentOffset.y -= topInsetDelta
//                    self.currentContentOffsets[scrollView] = contentOffset
//
//                    if userDelta > 0 { // apply user delta
//                        contentOffset.y += userDelta
//                    }
//
//                    scrollView.contentOffset = contentOffset
//                }
//            }
        }
    }
}

extension AutoInsetter {
    
    private func makeInsetCalculator(for scrollView: UIScrollView, viewController: UIViewController) -> InsetCalculator {
        
        if let tableView = scrollView as? UITableView {
            return TableViewInsetCalculator(view: tableView, viewController: viewController)
        }
        return ScrollViewInsetCalculator(view: scrollView, viewController: viewController)
    }
}

// MARK: - Utilities
private extension AutoInsetter {
    
    /// Calculate the actual inset values to use for a scroll view.
    ///
    /// - Parameters:
    ///   - scrollView: Scroll view.
    ///   - requiredInsets: Required TabmanBar insets.
    ///   - viewController: The view controller that contains the scroll view.
    /// - Returns: Actual contentInset values to use.
    func calculateActualRequiredContentInset(for scrollView: UIScrollView,
                                             from requiredInsetSpec: AutoInsetSpec,
                                             in viewController: UIViewController) -> UIEdgeInsets {
        viewController.view.layoutIfNeeded()
        
        let requiredContentInset = requiredInsetSpec.allRequiredInsets
        let previousContentInset = currentContentInsets[scrollView] ?? .zero
        
        // Calculate top / bottom insets relative to view position in child vc.
        var proposedContentInset: UIEdgeInsets
        
        if isEmbeddedViewController(viewController) { // Embedded VC is always full canvas
            proposedContentInset = requiredContentInset
            
        } else { // Standard View controller
            
            let relativeFrame = viewController.view.convert(scrollView.frame, from: scrollView.superview)
            let relativeTopInset = max(requiredContentInset.top - relativeFrame.minY, 0.0)
            let bottomInsetMinY = viewController.view.bounds.height - requiredContentInset.bottom
            let relativeBottomInset = abs(min(bottomInsetMinY - relativeFrame.maxY, 0.0))
            let originalContentInset = scrollView.contentInset
            
            proposedContentInset = UIEdgeInsets(top: relativeTopInset,
                                                left: originalContentInset.left,
                                                bottom: relativeBottomInset,
                                                right: originalContentInset.right)
        }
        
        currentContentInsets[scrollView] = proposedContentInset
                
        var actualRequiredContentInset = proposedContentInset
        
        // Take into account any custom insets for top / bottom
        if scrollView.contentInset.top != 0.0 {
            let customTopInset = scrollView.contentInset.top - previousContentInset.top
            actualRequiredContentInset.top += customTopInset
        }
        if scrollView.contentInset.bottom != 0.0 {
            let customBottomInset = scrollView.contentInset.bottom - previousContentInset.bottom
            actualRequiredContentInset.bottom += customBottomInset
        }
        
        return actualRequiredContentInset
    }
    
    /// Check whether a view controller is an 'embedded' view controller type (i.e. UITableViewController)
    ///
    /// - Parameters:
    ///   - viewController: The view controller.
    ///   - success: Execution if view controller is not embedded type.
    func isEmbeddedViewController(_ viewController: UIViewController) -> Bool {
        if (viewController is UITableViewController) || (viewController is UICollectionViewController) {
            return true
        }
        return false
    }
}
