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
}
