//
//  CGFloat.swift
//  Toolkit
//
//  Created by Roman Madyanov on 20/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import CoreGraphics

extension CGFloat
{
    public func interpolated(from: CGFloat = 0, to: CGFloat = 1) -> CGFloat {
        return (1 - self) * from + self * to
    }
}

extension CGFloat
{
    public var sign: CGFloat { return self >= 0 ? 1 : -1 }
}

extension CGFloat
{
    public static var standardSpacing: CGFloat { return 8 }
    public static var tappableSize: CGFloat { return 44 }
}
