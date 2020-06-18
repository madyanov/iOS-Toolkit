//
//  CachedImageView.swift
//  Toolkit
//
//  Created by Roman Madyanov on 23/09/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import UIKit

open class CachedImageView: UIImageView
{
    private lazy var blurView: UIVisualEffectView = {
        let visualEffectView = UIVisualEffectView()
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.isHidden = true
        return visualEffectView
    }()

    private var urlSessionDataTask: URLSessionDataTask?
    private var url: URL?

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

        setImage(with: placeholderURL, persistent: persistent) { _ in
            self.setImage(with: url, persistent: persistent) { success in
                guard self.url == url, success, placeholderURL != nil else {
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
}

extension CachedImageView
{
    private func setImage(with url: URL?, persistent: Bool = false, completion: ((Bool) -> Void)? = nil) {
        urlSessionDataTask?.cancel()

        guard let url = url else {
            completion?(false)
            return
        }

        self.url = url

        urlSessionDataTask = ImageCache.shared.load(from: url, persistent: persistent, guard: {
            self.url == url
        }, completion: { image, _ in
            guard let image = image else {
                completion?(false)
                return
            }

            UIView.transition(
                with: self,
                duration: 0.3,
                options: .transitionCrossDissolve,
                animations: { self.image = image }
            )

            completion?(true)
        })
    }
}
