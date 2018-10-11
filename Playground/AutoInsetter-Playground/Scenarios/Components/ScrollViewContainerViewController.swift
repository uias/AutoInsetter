//
//  ScrollViewContainerViewController.swift
//  AutoInsetter-Playground
//
//  Created by Merrick Sapsford on 11/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class ScrollViewContainerViewController<ScrollViewType: UIScrollView>: UIViewController {
    
    // MARK: Properties
    
    let scrollView = ScrollViewType()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
}
