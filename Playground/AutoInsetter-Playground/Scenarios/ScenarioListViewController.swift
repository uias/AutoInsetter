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
        navigationController?.pushViewController(scenario.makeViewController(), animated: true)
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
    
    var numberOfPages: Int {
        return 5
    }
}

private extension ScenarioListViewController.Scenario {
    
    func makeViewController() -> UIViewController {
        switch self {
        case .uiTableView:
            return ScenarioViewController<TableViewTestViewController>.init(numberOfPages: numberOfPages)
        case .uiCollectionView:
            return ScenarioViewController<CollectionViewTestViewController>.init(numberOfPages: numberOfPages)
        case .uiTableViewController:
            return ScenarioViewController<UITableViewController>.init(numberOfPages: numberOfPages)
        }
    }
}
