//
//  UITextField.swift
//  Toolkit
//
//  Created by Roman Madyanov on 13/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import UIKit

extension UITextField
{
    public func setTextStyle(_ textStyle: UIFont.TextStyle) {
        font = .preferredFont(forTextStyle: textStyle)
        adjustsFontForContentSizeCategory = true
    }
}
