//
//  UIEdgeInsets.swift
//  Toolkit
//
//  Created by Roman Madyanov on 11/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Convenient initializers
extension UIEdgeInsets {
    public var inversed: UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }

    public var horizontal: CGFloat {
        return left + right
    }

    public var vertical: CGFloat {
        return top + bottom
    }

    public init(_ insets: CGFloat) {
        self.init(top: insets, left: insets, bottom: insets, right: insets)
    }

    public init(dx: CGFloat, dy: CGFloat) {
        self.init(top: dy, left: dx, bottom: dy, right: dx)
    }
}
