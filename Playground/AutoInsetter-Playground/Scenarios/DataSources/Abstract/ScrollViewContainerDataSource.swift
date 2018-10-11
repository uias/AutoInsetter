//
//  ScrollViewContainerDataSource.swift
//  AutoInsetter-Playground
//
//  Created by Merrick Sapsford on 11/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class ScrollViewContainerDataSource<ScrollViewType: UIScrollView>: ScenarioDataSource<ScrollViewContainerViewController<ScrollViewType>> {
    
    let scrollView: ScrollViewType
    
    required init(viewController: ScrollViewContainerViewController<ScrollViewType>) {
        self.scrollView = viewController.scrollView
        super.init(viewController: viewController)
    }
}
