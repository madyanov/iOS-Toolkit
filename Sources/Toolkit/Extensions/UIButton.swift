//
//  UIButton.swift
//  Toolkit
//
//  Created by Roman Madyanov on 06/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import UIKit

extension UIButton
{
    public func centerTitleAndImageWithSpacing(_ spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }

    public func moveImageToRight() {
        transform = CGAffineTransform(scaleX: -1, y: 1)
        titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
        imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
}

extension UIButton
{
    public func setTextStyle(_ textStyle: UIFont.TextStyle) {
        titleLabel?.font = .preferredFont(forTextStyle: textStyle)
        titleLabel?.adjustsFontForContentSizeCategory = true
        titleLabel?.lineBreakMode = .byClipping

        if #available(iOS 11.0, *) {
            adjustsImageSizeForAccessibilityContentSizeCategory = true
        }
    }
}
