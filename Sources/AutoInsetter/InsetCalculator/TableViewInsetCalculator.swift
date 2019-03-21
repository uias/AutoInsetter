//
//  TableViewInsetCalculator.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 16/03/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

class TableViewInsetCalculator: ViewInsetCalculator<UITableView> {
    
    override func calculateContentInset(from spec: AutoInsetSpec, store: InsetStore) -> ContentInsetCalculation? {
        return nil
    }
    
    override func calculateContentOffset(from insetCalculation: ContentInsetCalculation, store: InsetStore) -> CGPoint? {
        return nil
    }
    
    override func calculateScrollIndicatorInsets(from spec: AutoInsetSpec) -> UIEdgeInsets? {
        return nil
    }
}
