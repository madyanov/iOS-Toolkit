//
//  UINavigationController.swift
//  Toolkit
//
//  Created by Roman Madyanov on 14/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import UIKit

extension UINavigationController
{
    // swiftlint:disable:next override_in_extension
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
