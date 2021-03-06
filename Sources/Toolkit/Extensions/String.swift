//
//  String.swift
//  Toolkit
//
//  Created by Roman Madyanov on 30/09/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import CommonCrypto

extension String
{
    public func date(with format: String = "yyyy-MM-dd") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)
    }
}

extension String
{
    public func localized(comment: String, _ arguments: CVarArg...) -> String {
        return String(
            format: NSLocalizedString(self, comment: comment),
            locale: .current,
            arguments: arguments
        )
    }
}

extension String
{
    public func truncated(length: Int, trailing: String = "…") -> String {
        return count > length ? prefix(length) + trailing : self
    }
}

extension String
{
    public var capitalizingFirstLetter: String {
        return prefix(1).uppercased() + dropFirst()
    }
}

extension String
{
    public var sha1: String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        let hash: [UInt8] = data.withUnsafeBytes { pointer in
            var hash = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
            CC_SHA1(pointer.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }

        return hash.map { String(format: "%02x", $0) }.joined()
    }

    public var md5: String? {
        guard let data = self.data(using: .utf8) else {
            return nil
        }

        let hash: [UInt8] = data.withUnsafeBytes { pointer in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(pointer.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }

        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
