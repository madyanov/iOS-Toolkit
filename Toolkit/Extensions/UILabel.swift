//
//  UILabel.swift
//  Toolkit
//
//  Created by Roman Madyanov on 11/10/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Font adjustment
public extension UILabel {
    func setTextStyle(_ textStyle: UIFont.TextStyle) {
        font = .preferredFont(forTextStyle: textStyle)
        adjustsFontForContentSizeCategory = true
    }
}

// MARK: - Truncation checking
public extension UILabel {
    var isTruncated: Bool {
        return numberOfLines > 0 && realNumberOfLines > numberOfLines
    }

    var realNumberOfLines: Int {
        let height = text?.boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: font],
            context: nil
        ).size.height ?? 0

        return Int(ceil(height / font.lineHeight))
    }
}
