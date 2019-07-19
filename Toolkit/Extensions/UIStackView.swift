//
//  UIStackView.swift
//  Toolkit
//
//  Created by Roman Madyanov on 11/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import UIKit

extension UIStackView
{
    public func margin(_ margins: UIEdgeInsets) {
        layoutMargins = margins
        isLayoutMarginsRelativeArrangement = true

        if #available(iOS 11.0, *) {
            insetsLayoutMarginsFromSafeArea = false
        }
    }
}
