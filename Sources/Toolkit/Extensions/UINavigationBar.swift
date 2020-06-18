//
//  UINavigationBar.swift
//  Toolkit
//
//  Created by Roman Madyanov on 14/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import UIKit

extension UINavigationBar {
    public func removeShadow() {
        shadowImage = UIImage()
        setValue(true, forKey: "hidesShadow")
    }

    // swiftlint:disable:next override_in_extension
    override open func setValue(_ value: Any?, forUndefinedKey key: String) {
        guard key != "hidesShadow" else {
            return
        }

        super.setValue(value, forUndefinedKey: key)
    }
}

extension UINavigationBar
{
    public func makeTransparent() {
        removeShadow()
        isTranslucent = true
        setBackgroundImage(UIImage(), for: .default)
    }
}
