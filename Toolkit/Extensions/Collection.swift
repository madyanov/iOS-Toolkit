//
//  Collection.swift
//  Toolkit
//
//  Created by Roman Madyanov on 30/09/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation

// MARK: - Safe subscription
extension Collection {
    public subscript (at index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
