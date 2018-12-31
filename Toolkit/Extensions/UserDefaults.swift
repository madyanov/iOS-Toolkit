//
//  UserDefaults.swift
//  Toolkit
//
//  Created by Roman Madyanov on 12/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation

public class DefaultsKeys {
    fileprivate init() { } // swiftlint:disable:this strict_fileprivate
}

public class DefaultsKey<T>: DefaultsKeys {
    let name: String

    public init(_ name: String) {
        self.name = name
    }
}

extension UserDefaults {
    public subscript(key: DefaultsKey<String>) -> String? {
        get { return string(forKey: key.name) }
        set { set(newValue, forKey: key.name) }
    }

    public subscript(key: DefaultsKey<Int>) -> Int {
        get { return integer(forKey: key.name) }
        set { set(newValue, forKey: key.name) }
    }

    public subscript(key: DefaultsKey<Float>) -> Float {
        get { return float(forKey: key.name) }
        set { set(newValue, forKey: key.name) }
    }

    public subscript(key: DefaultsKey<Double>) -> Double {
        get { return double(forKey: key.name) }
        set { set(newValue, forKey: key.name) }
    }

    public subscript(key: DefaultsKey<Bool>) -> Bool {
        get { return bool(forKey: key.name) }
        set { set(newValue, forKey: key.name) }
    }

    public subscript(key: DefaultsKey<URL>) -> URL? {
        get { return url(forKey: key.name) }
        set { set(newValue, forKey: key.name) }
    }

    public subscript(key: DefaultsKey<Data>) -> Data? {
        get { return data(forKey: key.name) }
        set { set(newValue, forKey: key.name) }
    }

    public subscript<T>(key: DefaultsKey<T>) -> T? {
        get { return object(forKey: key.name) as? T }
        set { set(newValue, forKey: key.name) }
    }

    public subscript<T: Codable>(key: DefaultsKey<T>) -> T? {
        get {
            guard let data = data(forKey: key.name) else {
                return object(forKey: key.name) as? T
            }

            return try? JSONDecoder().decode(T.self, from: data)
        }
        set {
            guard let value = newValue, let data = try? JSONEncoder().encode(value) else {
                set(newValue, forKey: key.name)
                return
            }

            set(data, forKey: key.name)
        }
    }
}
