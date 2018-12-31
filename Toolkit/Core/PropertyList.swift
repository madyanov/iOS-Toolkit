//
//  PropertyList.swift
//  Toolkit
//
//  Created by Roman Madyanov on 27/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation

public class PropertyListKeys {
    fileprivate init() { } // swiftlint:disable:this strict_fileprivate
}

public final class PropertyListKey<N, T>: PropertyListKeys {
    let name: String

    public init(_ name: String) {
        self.name = name
    }
}

public final class PropertyList<N> {
    private let propertyList: [String: Any]

    public init(name: String, extension: String = "plist") throws {
        guard let fileURL = Bundle.main.url(forResource: name, withExtension: `extension`) else {
            throw Error.fileNotFound
        }

        do {
            let data = try Data(contentsOf: fileURL)

            do {
                propertyList = try PropertyListSerialization.propertyList(
                    from: data,
                    options: [],
                    format: nil
                ) as? [String: Any] ?? [:]
            } catch {
                throw Error.invalidPropertyList(error)
            }
        } catch {
            throw Error.fileNotReadable(error)
        }
    }

    public subscript<T>(key: PropertyListKey<N, T>) -> T? {
        return propertyList[key.name] as? T
    }
}

extension PropertyList {
    public enum Error: Swift.Error {
        case fileNotFound
        case fileNotReadable(Swift.Error)
        case invalidPropertyList(Swift.Error)
    }
}
