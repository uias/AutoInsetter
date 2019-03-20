//
//  InsetCalculations.swift
//  AutoInsetter
//
//  Created by Merrick Sapsford on 20/03/2019.
//  Copyright © 2019 UI At Six. All rights reserved.
//

import UIKit

struct ContentInsetCalculation {
    /// The new Content Inset
    let new: UIEdgeInsets
    /// The previously calculated Content Inset
    let previous: UIEdgeInsets?
    /// The current actual Content Inset of the view.
    let currentActual: UIEdgeInsets
}
