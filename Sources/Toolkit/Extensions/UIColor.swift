//
//  UIColor.swift
//  Toolkit
//
//  Created by Roman Madyanov on 13/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import UIKit

extension UIColor
{
    public static let clearWhite = UIColor.white.withAlphaComponent(0)
}

extension UIColor
{
    public convenience init(hex: Int, alpha: CGFloat = 1) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            alpha: alpha
        )
    }

    public convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat(red) / 255,
            green: CGFloat(green) / 255,
            blue: CGFloat(blue) / 255,
            alpha: alpha
        )
    }
}

extension UIColor
{
    public static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1
        )
    }
}

extension UIColor
{
    public func lighterBy(_ by: CGFloat) -> UIColor? {
        return blend(with: .white, alpha: by)
    }

    public func darkerBy(_ by: CGFloat) -> UIColor? {
        return blend(with: .black, alpha: by)
    }

    public func blend(with color: UIColor, alpha: CGFloat = 0.5) -> UIColor {
        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0

        guard getRed(&r1, green: &g1, blue: &b1, alpha: &a1),
              color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
        else {
            return self
        }

        return UIColor(
            red: r1 * (1 - alpha) + r2 * alpha,
            green: g1 * (1 - alpha) + g2 * alpha,
            blue: b1 * (1 - alpha) + b2 * alpha,
            alpha: a1 * (1 - alpha) + a2 * alpha
        )
    }
}

extension UIColor
{
    public func image(size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image! // swiftlint:disable:this force_unwrapping
    }
}
