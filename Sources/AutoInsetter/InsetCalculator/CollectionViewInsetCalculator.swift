//
//  CollectionViewInsetCalculator.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 23/03/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

internal class CollectionViewInsetCalculator: ViewInsetCalculator<UICollectionView> {
    
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
