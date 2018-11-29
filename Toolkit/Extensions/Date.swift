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

// MARK: - Date defference
public extension Date {
    func years(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.year], from: date, to: self).year
    }

    func months(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.month], from: date, to: self).month
    }

    func days(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: date, to: self).day
    }

    func hours(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour
    }

    func minutes(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute
    }

    func seconds(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.second], from: date, to: self).second
    }
}
