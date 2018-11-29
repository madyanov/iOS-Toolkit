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
public extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

// MARK: - Interpolation
public extension CGFloat {
    func interpolated(from: CGFloat = 0, to: CGFloat = 1) -> CGFloat {
        return (1 - self) * from + self * to
    }
}

// MARK: - Sign
public extension CGFloat {
    var sign: CGFloat {
        return self >= 0 ? 1 : -1
    }
}
