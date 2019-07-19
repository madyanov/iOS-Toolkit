//
//  Date.swift
//  Toolkit
//
//  Created by Roman Madyanov on 21/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

extension Date
{
    public var year: String {
        return "\(Calendar.current.component(.year, from: self))"
    }
}

extension Date
{
    public func years(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.year], from: date, to: self).year
    }

    public func months(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.month], from: date, to: self).month
    }

    public func days(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.day], from: date, to: self).day
    }

    public func hours(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour
    }

    public func minutes(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute
    }

    public func seconds(since date: Date) -> Int? {
        return Calendar.current.dateComponents([.second], from: date, to: self).second
    }
}
