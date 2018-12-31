//
//  Comparable.swift
//  Toolkit
//
//  Created by Roman Madyanov on 24/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation

// MARK: - Clamping
extension Comparable {
    public func clamped(to range: ClosedRange<Self>) -> Self {
        return self < range.lowerBound
            ? range.lowerBound
            : (range.upperBound < self ? range.upperBound : self)
    }
}
