//
//  Date.swift
//  Toolkit
//
//  Created by Roman Madyanov on 21/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation

// MARK: - Stringifying
public extension Date {
    var year: String {
        return "\(Calendar.current.component(.year, from: self))"
    }
}
