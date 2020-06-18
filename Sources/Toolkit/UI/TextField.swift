//
//  TextField.swift
//  Toolkit
//
//  Created by Roman Madyanov on 13/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import UIKit

open class TextField: UITextField
{
    open var insets = UIEdgeInsets(.standardSpacing)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    public convenience init() {
        self.init(frame: .zero)
        setTextStyle(.callout)
    }
}
