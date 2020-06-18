//
//  CALayer.swift
//  Toolkit
//
//  Created by Roman Madyanov on 06/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import UIKit

extension CALayer
{
    public func rasterize() {
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
    }
}
