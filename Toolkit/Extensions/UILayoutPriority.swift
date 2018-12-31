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
extension UILayoutPriority {
    public static let highest = UILayoutPriority(rawValue: 999)
    public static let lowest = UILayoutPriority(rawValue: 1)

    public static func withValue(_ value: Float) -> UILayoutPriority {
        return UILayoutPriority(rawValue: value)
    }

    public static func + (left: UILayoutPriority, right: Float) -> UILayoutPriority {
        return UILayoutPriority(rawValue: left.rawValue + right)
    }
}
