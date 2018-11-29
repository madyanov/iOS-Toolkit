//
//  Lazy.swift
//  Toolkit
//
//  Created by Roman Madyanov on 20/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation

public struct Lazy<T> {
    private var initializer: () -> T
    private var valueHolder: Value<T> = .none

    public init(initializer: @escaping () -> T) {
        self.initializer = initializer
    }

    public var value: T {
        mutating get {
            switch valueHolder {
            case .some(let value):
                return value
            case .none:
                let value = initializer()
                valueHolder = .some(value)
                return value
            }
        }
        set { valueHolder = .some(newValue) }
    }

    public mutating func reset() {
        valueHolder = .none
    }
}

extension Lazy {
    private enum Value<T> {
        case none
        case some(T)
    }
}
