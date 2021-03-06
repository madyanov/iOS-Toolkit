//
//  UILayoutGuide.swift
//  Toolkit
//
//  Created by Roman Madyanov on 18/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import UIKit

extension UILayoutGuide
{
    public func snap(to view: UIView? = nil,
                     insets: UIEdgeInsets = .zero,
                     safe: Bool = false,
                     priority: UILayoutPriority = .required)
    {
        guard let view = view ?? owningView else {
            return
        }

        if #available(iOS 11.0, *), safe {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),
                trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -insets.right),
            ], priority: priority)
        } else {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
                trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            ], priority: priority)
        }

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom),
        ], priority: priority)
    }

    public func center(in view: UIView? = nil, priority: UILayoutPriority = .required) {
        guard let view = view ?? owningView else {
            return
        }

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ], priority: priority)
    }

    public func size(_ size: CGSize) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height),
        ])
    }

    public func snap(to layoutGuide: UILayoutGuide,
                     insets: UIEdgeInsets = .zero,
                     safe: Bool = false,
                     priority: UILayoutPriority = .required)
    {
        guard let superview = owningView else {
            return
        }

        if #available(iOS 11.0, *), safe {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: insets.left),

                trailingAnchor.constraint(
                    equalTo: superview.safeAreaLayoutGuide.trailingAnchor,
                    constant: -insets.right
                ),
            ], priority: priority)
        } else {
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: insets.left),
                trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: -insets.right),
            ], priority: priority)
        }

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -insets.bottom),
        ], priority: priority)
    }

    public func center(in layoutGuide: UILayoutGuide, priority: UILayoutPriority = .required) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
            centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
        ], priority: priority)
    }
}
