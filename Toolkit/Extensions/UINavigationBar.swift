//
//  UINavigationBar.swift
//  Toolkit
//
//  Created by Roman Madyanov on 14/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Shadow removing
extension UINavigationBar {
    public func removeShadow() {
        shadowImage = UIImage()
        setValue(true, forKey: "hidesShadow")
    }

    override open func setValue(_ value: Any?, forUndefinedKey key: String) {
        guard key != "hidesShadow" else {
            return
        }

        super.setValue(value, forUndefinedKey: key)
    }
}

// MARK: - Transparency
extension UINavigationBar {
    public func makeTransparent() {
        removeShadow()
        isTranslucent = true
        setBackgroundImage(UIImage(), for: .default)
    }
}
