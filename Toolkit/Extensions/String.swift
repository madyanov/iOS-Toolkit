//
//  String.swift
//  Toolkit
//
//  Created by Roman Madyanov on 30/09/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation

// MARK: - Dates
public extension String {
    var date: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: self)
    }
}

// MARK: - Localization
public extension String {
    func localized(comment: String, _ arguments: CVarArg...) -> String {
        return String(
            format: NSLocalizedString(self, comment: comment),
            locale: .current,
            arguments: arguments
        )
    }
}

// MARK: - Truncating
public extension String {
    func truncated(length: Int, trailing: String = "…") -> String {
        return count > length ? prefix(length) + trailing : self
    }
}

// MARK: - Capitalizing
public extension String {
    var capitalizingFirstLetter: String {
        return prefix(1).uppercased() + dropFirst()
    }
}

// MARK: - Hashing
public extension String {
    var sha1: String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        let hash: [UInt8] = data.withUnsafeBytes { (bytes: UnsafePointer<Data>) in
            var hash = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
            CC_SHA1(bytes, CC_LONG(data.count), &hash)
            return hash
        }

        return hash.map { String(format: "%02x", $0) }.joined()
    }

    var md5: String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        let hash: [UInt8] = data.withUnsafeBytes { (bytes: UnsafePointer<Data>) in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes, CC_LONG(data.count), &hash)
            return hash
        }

        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
