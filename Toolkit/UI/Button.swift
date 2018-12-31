//
//  Button.swift
//  Toolkit
//
//  Created by Roman Madyanov on 06/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

open class Button: UIButton {
    open var hightlightedBackgroundColor: UIColor?
    open var disabledBackgroundColor: UIColor?
    open var highlightedAlpha: CGFloat = 1

    open var defaultBackgroundColor: UIColor? {
        didSet { backgroundColor = defaultBackgroundColor }
    }

    private var backgroundGradientLayer: CAGradientLayer?

    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = hightlightedBackgroundColor ?? defaultBackgroundColor
                alpha = highlightedAlpha
            } else {
                backgroundColor = defaultBackgroundColor
                alpha = 1
            }
        }
    }

    override open var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = defaultBackgroundColor
            } else {
                backgroundColor = disabledBackgroundColor ?? defaultBackgroundColor
            }
        }
    }

    public convenience init() {
        self.init(type: .system)
        setTextStyle(.callout)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()
        backgroundGradientLayer?.frame = bounds
    }

    public func addGradient(
        colors: [UIColor],
        startPoint: CGPoint = .zero,
        endPoint: CGPoint = CGPoint(x: 1, y: 1)
    ) {
        let gradientLayer = backgroundGradientLayer ?? CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.insertSublayer(gradientLayer, at: 0)
        _ = imageView.map { bringSubviewToFront($0) }
        backgroundGradientLayer = gradientLayer
    }

    public func removeGradient() {
        backgroundGradientLayer?.removeFromSuperlayer()
    }
}
