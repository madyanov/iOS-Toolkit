//
//  Optional.swift
//  Toolkit
//
//  Created by Roman Madyanov on 12/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation

// MARK: - Convenient unwrapping
public extension Optional {
    @discardableResult
    func unwrap<T>(default: T? = nil, _ block: (Wrapped) -> (T)) -> T? {
        switch self {
        case .some(let wrapped): return block(wrapped)
        case .none: return `default`
        }
    }
}

infix operator ??=

// swiftlint:disable:next static_operator
public func ??= <T>(left: inout T?, right: T?) {
    left = left ?? right
}
