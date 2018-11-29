//
//  Coordinator.swift
//  Toolkit
//
//  Created by Roman Madyanov on 23/09/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

public protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var viewController: UIViewController { get }

    func start()
    func stop()
}

public extension Coordinator {
    func start() { }
    func stop() { }

    func startCoordinator(_ coordinator: Coordinator) {
        guard !hasCoordinator(coordinator) else {
            print("!!! Coordinator \(String(describing: coordinator)) is already started")
            return
        }

        childCoordinators.append(coordinator)
        coordinator.start()
    }

    func stopCoordinator(_ coordinator: Coordinator) {
        guard hasCoordinator(coordinator) else {
            print("!!! Coordinator \(String(describing: coordinator)) is not started")
            return
        }

        coordinator.stop()
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }

    func hasCoordinator(_ coordinator: Coordinator) -> Bool {
        return childCoordinators.contains { $0 === coordinator }
    }
}
