//
//  CGFloat.swift
//  Toolkit
//
//  Created by Roman Madyanov on 20/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import CoreGraphics

// MARK: - Random number
extension CGFloat {
    public static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

// MARK: - Interpolation
extension CGFloat {
    public func interpolated(from: CGFloat = 0, to: CGFloat = 1) -> CGFloat {
        return (1 - self) * from + self * to
    }
}

// MARK: - Sign
extension CGFloat {
    public var sign: CGFloat {
        return self >= 0 ? 1 : -1
    }
}
