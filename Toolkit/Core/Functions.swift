//
//  Functions.swift
//  Toolkit
//
//  Created by Roman Madyanov on 23/09/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

public func debounce<T>(_ interval: TimeInterval, action: @escaping (T) -> Void) -> ((T) -> Void) {
    var task: DispatchWorkItem?

    return { value in
        task?.cancel()
        task = DispatchWorkItem { action(value) }

        if let task = task {
            DispatchQueue.main.asyncAfter(deadline: .now() + interval, execute: task)
        }
    }
}
