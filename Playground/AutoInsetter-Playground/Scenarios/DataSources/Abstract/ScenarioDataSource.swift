//
//  ScenarioDataSource.swift
//  AutoInsetter-Playground
//
//  Created by Merrick Sapsford on 11/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class ScenarioDataSource<ViewControllerType: UIViewController> {
    
    let viewController: ViewControllerType
    
    required init(viewController: ViewControllerType) {
        self.viewController = viewController
        configure()
    }
    
    // MARK: Lifecycle
    
    func configure() {
        
    }
}
