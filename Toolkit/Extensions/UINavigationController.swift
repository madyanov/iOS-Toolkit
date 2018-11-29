//
//  UINavigationController.swift
//  Toolkit
//
//  Created by Roman Madyanov on 14/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Status bar styling
extension UINavigationController {
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
