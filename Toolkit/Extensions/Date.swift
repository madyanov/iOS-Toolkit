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

    var localizedString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter.string(from: self)
    }
}
