//
//  UIColor.swift
//  Toolkit
//
//  Created by Roman Madyanov on 13/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Color presets
extension UIColor {
    public static let clearWhite = UIColor.white.withAlphaComponent(0)
}

// MARK: - Hex colors
extension UIColor {
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

// MARK: - Random color
extension UIColor {
    public static var random: UIColor {
        return UIColor(
            red: .random,
            green: .random,
            blue: .random,
            alpha: 1
        )
    }
}

// MARK: - Color blending
extension UIColor {
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
