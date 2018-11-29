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
public extension UIEdgeInsets {
    var inversed: UIEdgeInsets {
        return UIEdgeInsets(top: -top, left: -left, bottom: -bottom, right: -right)
    }

    var horizontal: CGFloat {
        return left + right
    }

    var vertical: CGFloat {
        return top + bottom
    }

    init(_ insets: CGFloat) {
        self.init(top: insets, left: insets, bottom: insets, right: insets)
    }

    init(dx: CGFloat, dy: CGFloat) {
        self.init(top: dy, left: dx, bottom: dy, right: dx)
    }
}
