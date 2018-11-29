//
//  UILayoutPriority.swift
//  Toolkit
//
//  Created by Roman Madyanov on 28/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Additional priorities
public extension UILayoutPriority {
    static let highest = UILayoutPriority(rawValue: 999)
    static let lowest = UILayoutPriority(rawValue: 1)

    static func withValue(_ value: Float) -> UILayoutPriority {
        return UILayoutPriority(rawValue: value)
    }

    static func + (left: UILayoutPriority, right: Float) -> UILayoutPriority {
        return UILayoutPriority(rawValue: left.rawValue + right)
    }
}
