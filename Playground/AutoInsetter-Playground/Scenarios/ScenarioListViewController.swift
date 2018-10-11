//
//  ScenarioListViewController.swift
//  AutoInsetter-Playground
//
//  Created by Merrick Sapsford on 11/10/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

class ScenarioListViewController: UITableViewController {
    
    // MARK: Types
    
    enum Scenario: CaseIterable {
        case uiTableView
        case uiTableViewController
        case uiCollectionView
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Scenario.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "Cell"
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        
        let scenario = Scenario.allCases[indexPath.row]
        cell.textLabel?.text = scenario.title
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scenario = Scenario.allCases[indexPath.row]
        
        let viewController = ScenarioViewController(numberOfPages: scenario.numberOfPages)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ScenarioListViewController.Scenario {
    
    var title: String {
        switch self {
        case .uiTableView:
            return "UITableView"
        case .uiTableViewController:
            return "UITableViewController"
        case .uiCollectionView:
            return "UICollectionView"
        }
    }
    
    var viewControllerType: UIViewController.Type {
        switch self {
        case .uiTableView:
            return ScrollViewContainerViewController<UITableView>.self
        case .uiCollectionView:
            return ScrollViewContainerViewController<UICollectionView>.self
        case .uiTableViewController:
            return UITableViewController.self
        }
    }
    
    var numberOfPages: Int {
        return 5
    }
}