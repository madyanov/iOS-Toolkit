//
//  Optional.swift
//  Toolkit
//
//  Created by Roman Madyanov on 12/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation

infix operator ??=

// swiftlint:disable:next static_operator
public func ??= <T>(left: inout T?, right: T?) {
    left = left ?? right
}
