//
//  ImageCache.swift
//  Toolkit
//
//  Created by Roman Madyanov on 29/09/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import UIKit

public final class ImageCache {
    public static let shared = ImageCache()

    private init() { }

    private lazy var cache = NSCache<NSURL, CacheRecord>()

    private lazy var cachedImagesDirectory: URL? = {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first

        guard let cachedImagesDirectory = documentDirectory?.appendingPathComponent("Cached Images") else {
            return nil
        }

        try? FileManager.default.createDirectory(
            atPath: cachedImagesDirectory.path,
            withIntermediateDirectories: true,
            attributes: nil
        )

        return cachedImagesDirectory
    }()

    @discardableResult
    public func load(
        from url: URL,
        persistent: Bool = false,
        timeout: TimeInterval = 60,
        guard: (() -> Bool)? = nil,
        completion: ((UIImage?, Error?) -> Void)? = nil
    ) -> URLSessionDataTask? {
        if let image = image(for: url, persistent: persistent) {
            DispatchQueue.main.async { completion?(image, nil) }
            return nil
        }

#if DEBUG
        let urlRequest = URLRequest(
            url: url,
            cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
            timeoutInterval: timeout
        )
#else
        let urlRequest = URLRequest(url: url, timeoutInterval: timeout)
#endif

        let urlSessionDataTask = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            guard `guard`?() ?? true else {
                print("!!! Image Cache: load \(url.absoluteString) - guarded")
                DispatchQueue.main.async { completion?(nil, .guarded) }
                return
            }

            if let error = error {
                print("!!! Image Cache: load \(url.absoluteString) - \(error.localizedDescription)")
                DispatchQueue.main.async { completion?(nil, .network(error)) }
                return
            }

            if let httpURLResponse = urlResponse as? HTTPURLResponse,
                httpURLResponse.statusCode < 200 || httpURLResponse.statusCode >= 300
            {
                print("!!! Image Cache: load \(url.absoluteString) - HTTP Status Code \(httpURLResponse.statusCode)")
                DispatchQueue.main.async { completion?(nil, .http(httpURLResponse.statusCode)) }
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("!!! Image Cache: load \(url.absoluteString) - response is not image")
                DispatchQueue.main.async { completion?(nil, .invalidResponse) }
                return
            }

            self.save(data: data, for: url, persistent: persistent)
            DispatchQueue.main.async { completion?(image, nil) }
        }

        urlSessionDataTask.resume()
        return urlSessionDataTask
    }

    public func warmUp(limit: Int = 1000) {
        guard let cachedImagesDirectory = cachedImagesDirectory else {
            return
        }

        DispatchQueue.global(qos: .background).async {
            let urls = try? FileManager.default.contentsOfDirectory(
                at: cachedImagesDirectory,
                includingPropertiesForKeys: nil
            )

            urls?
                .map { cachedImagesDirectory.appendingPathComponent($0.lastPathComponent) }
                .prefix(limit)
                .forEach {
                    guard let data = try? Data(contentsOf: $0), UIImage(data: data) != nil else {
                        return
                    }

                    self.saveDataToMemory(data, persistent: true, localURL: $0)
                }
        }
    }

    public func clear(for url: URL) {
        guard let localURL = localImageURL(forRemote: url) else {
            return
        }

        cache.removeObject(forKey: localURL as NSURL)

        do {
            try FileManager.default.removeItem(at: localURL)
        } catch {
            print("!!! Image Cache: clear - \(error.localizedDescription)")
        }
    }

    private func image(for url: URL, persistent: Bool) -> UIImage? {
        guard let localURL = localImageURL(forRemote: url) else {
            return nil
        }

        if let cacheRecord = cache.object(forKey: localURL as NSURL), let image = UIImage(data: cacheRecord.data) {
            // copy data from memory to filesystem
            if persistent && !cacheRecord.isPersistent {
                DispatchQueue.global(qos: .background).async {
                    self.save(data: cacheRecord.data, for: url, persistent: persistent)
                }
            }

            return image
        }

        guard
            let data = try? Data(contentsOf: localURL),
            let image = UIImage(data: data)
        else {
            return nil
        }

        saveDataToMemory(data, persistent: persistent, localURL: localURL)
        return image
    }

    private func save(data: Data, for url: URL, persistent: Bool) {
        guard let localURL = localImageURL(forRemote: url) else {
            return
        }

        if UIImage(data: data) != nil {
            saveDataToMemory(data, persistent: persistent, localURL: localURL)
        }

        guard persistent else {
            return
        }

        do {
            try data.write(to: localURL)
        } catch {
            print("!!! Image Cache: save - \(error.localizedDescription)")
        }
    }

    private func localImageURL(forRemote url: URL) -> URL? {
        guard
            let sha1 = url.absoluteString.sha1,
            let cachedImagesDirectory = cachedImagesDirectory
        else {
            return nil
        }

        let fileName = url.lastPathComponent.prefix(16)
        return cachedImagesDirectory.appendingPathComponent("\(fileName)_\(sha1)")
    }

    private func saveDataToMemory(_ data: Data, persistent: Bool, localURL: URL) {
        cache.setObject(CacheRecord(data: data, isPersistent: persistent), forKey: localURL as NSURL)
    }
}

public extension ImageCache {
    enum Error: Swift.Error {
        case guarded
        case network(Swift.Error)
        case http(Int)
        case invalidResponse
    }
}

extension ImageCache {
    private class CacheRecord: NSObject {
        let data: Data
        let isPersistent: Bool

        init(data: Data, isPersistent: Bool) {
            self.data = data
            self.isPersistent = isPersistent
        }
    }
}
