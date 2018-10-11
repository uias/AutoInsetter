//
//  ScenarioViewController.swift
//  AutoInsetter-Playground
//
//  Created by Merrick Sapsford on 11/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class ScenarioViewController<ChildViewControllerType: UIViewController>: TabmanViewController, PageboyViewControllerDataSource {
    
    // MARK: Properties
    
    let viewControllers: [UIViewController]
    
    // MARK: Init
    
    init(numberOfPages: Int) {
        self.viewControllers = [UIViewController].init(repeating: ChildViewControllerType(),
                                                       count: numberOfPages)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not supported")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        dataSource = self
    }
    
    // MARK: PageboyViewControllerDataSource
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
