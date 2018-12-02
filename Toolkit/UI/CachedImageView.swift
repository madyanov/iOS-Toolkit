//
//  CachedImageView.swift
//  Toolkit
//
//  Created by Roman Madyanov on 23/09/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

open class CachedImageView: UIImageView {
    private var urlSessionDataTask: URLSessionDataTask?
    private var requestID = 0

    private lazy var blurView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.isHidden = true
        return visualEffectView
    }()

    public convenience init() {
        self.init(frame: .zero)
        addSubview(blurView)
        blurView.snap()
    }

    open func setImage(with url: URL?, placeholderURL: URL? = nil, persistent: Bool = false) {
        image = nil

        if placeholderURL != nil {
            blurView.effect = UIBlurEffect(style: .light)
            blurView.isHidden = false
        }

        setImage(with: placeholderURL, persistent: persistent) {
            self.setImage(with: url, persistent: persistent) {
                guard url != nil, placeholderURL != nil else {
                    return
                }

                UIView.animate(withDuration: 0.3, animations: {
                    self.blurView.effect = nil
                }, completion: { _ in
                    self.blurView.isHidden = true
                })
            }
        }
    }

    private func setImage(with url: URL?, persistent: Bool = false, completion: (() -> Void)? = nil) {
        urlSessionDataTask?.cancel()

        guard let url = url else {
            completion?()
            return
        }

        requestID += 1
        let currentRequestID = requestID

        urlSessionDataTask = ImageCache.shared.load(from: url, persistent: persistent, guard: {
            self.requestID == currentRequestID
        }, completion: { image, _ in
            guard let image = image else {
                completion?()
                return
            }

            UIView.transition(
                with: self,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: { self.image = image }
            )

            completion?()
        })
    }
}
