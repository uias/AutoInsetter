//
//  RequiredAutoInsets.swift
//  AutoInset
//
//  Created by Merrick Sapsford on 16/01/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import Foundation

public protocol RequiredAutoInsets {
    
    var additionalInsets: UIEdgeInsets { get }
    
    var totalInsets: UIEdgeInsets { get }
}
