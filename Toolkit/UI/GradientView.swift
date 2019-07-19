//
//  GradientView.swift
//  Toolkit
//
//  Created by Roman Madyanov on 13/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import UIKit

open class GradientView: UIView
{
    open var colors: [UIColor] = [] {
        didSet { gradientLayer?.colors = colors.map { $0.cgColor } }
    }

    open var startPoint: CGPoint {
        get { return gradientLayer?.startPoint ?? .zero }
        set { gradientLayer?.startPoint = newValue }
    }

    open var endPoint: CGPoint {
        get { return gradientLayer?.endPoint ?? .zero }
        set { gradientLayer?.endPoint = newValue }
    }

    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
}

extension GradientView
{
    private var gradientLayer: CAGradientLayer? {
        return layer as? CAGradientLayer
    }
}
