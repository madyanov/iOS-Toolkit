//
//  UIView.swift
//  Toolkit
//
//  Created by Roman Madyanov on 30/09/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Auto Layout
public extension UIView {
    func snap(
        to view: UIView? = nil,
        insets: UIEdgeInsets = .zero,
        safe: Bool = false,
        priority: UILayoutPriority = .required
    ) {
        guard let view = view ?? superview else {
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

    func center(in view: UIView? = nil, priority: UILayoutPriority = .required) {
        guard let view = view ?? superview else {
            return
        }

        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ], priority: priority)
    }

    func size(_ size: CGSize) {
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: size.width),
            heightAnchor.constraint(equalToConstant: size.height),
        ])
    }

    func snap(
        to layoutGuide: UILayoutGuide,
        insets: UIEdgeInsets = .zero,
        safe: Bool = false,
        priority: UILayoutPriority = .required
    ) {
        guard let superview = superview else {
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

    func center(in layoutGuide: UILayoutGuide, priority: UILayoutPriority = .required) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: layoutGuide.centerXAnchor),
            centerYAnchor.constraint(equalTo: layoutGuide.centerYAnchor),
        ], priority: priority)
    }
}

// MARK: - Safe Area Insets
public extension UIView {
    var globalSafeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return UIApplication.shared.keyWindow?.safeAreaInsets ?? safeAreaInsets
        } else {
            return .zero
        }
    }
}

// MARK: - Animation alongside keyboard
public extension UIView {
    class func animateAlongsideKeyboard(
        _ notification: Notification,
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber,
              let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        else {
            animations()
            return
        }

        UIView.animate(
            withDuration: duration.doubleValue,
            delay: 0,
            options: UIView.AnimationOptions(rawValue: UInt(curve.intValue << 16)),
            animations: animations,
            completion: completion
        )
    }
}
