//
//  Box.swift
//  Toolkit
//
//  Created by Roman Madyanov on 25/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

public struct Box<T>
{
    private var ref: Ref<T>

    public init(value: T) {
        ref = Ref(value: value)
    }

    public var value: T {
        get { return ref.value }
        set {
            guard isKnownUniquelyReferenced(&ref) else {
                ref = Ref(value: newValue)
                return
            }

            ref.value = newValue
        }
    }
}

extension Box where T: Equatable
{
    public static func == (left: Box, right: Box) -> Bool {
        return left.value == right.value
    }
}

public final class Ref<T>
{
    public var value: T

    public init(value: T) {
        self.value = value
    }
}

extension Ref where T: Equatable
{
    public static func == (left: Ref, right: Ref) -> Bool {
        return left.value == right.value
    }
}
