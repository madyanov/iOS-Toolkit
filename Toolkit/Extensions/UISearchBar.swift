//
//  UISearchBar.swift
//  Toolkit
//
//  Created by Roman Madyanov on 20/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Search field background color
extension UISearchBar {
    public func setSearchFieldBackgroundColor(_ color: UIColor, cornerRadius: CGFloat = 10) {
        guard let textField = value(forKey: "searchField") as? UITextField,
              let backgroundView = textField.subviews.first
        else {
            return
        }

        backgroundView.backgroundColor = color
        backgroundView.layer.cornerRadius = cornerRadius
        backgroundView.layer.masksToBounds = true
    }
}
