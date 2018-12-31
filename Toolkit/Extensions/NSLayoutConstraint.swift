//
//  NSLayoutConstraint.swift
//  Toolkit
//
//  Created by Roman Madyanov on 28/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

extension NSLayoutConstraint {
    public class func activate(_ constraints: [NSLayoutConstraint], priority: UILayoutPriority) {
        constraints.forEach { $0.priority = priority }
        NSLayoutConstraint.activate(constraints)
    }
}
