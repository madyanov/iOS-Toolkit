//
//  ConditionalPropertyOverwritingMergePolicy.swift
//  Toolkit
//
//  Created by Roman Madyanov on 11/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import CoreData

public protocol KeepingProperties {
    func shouldKeepProperty(_ property: String, databaseValue: Any?, contextValue: Any?) -> Bool
}

public final class ConditionalPropertyOverwritingMergePolicy: NSMergePolicy {
    override public func resolve(constraintConflicts list: [NSConstraintConflict]) throws {
        for conflict in list {
            for conflictingObject in conflict.conflictingObjects {
                guard let keepingProperties = conflictingObject as? KeepingProperties else {
                    continue
                }

                for key in conflictingObject.entity.attributesByName.keys {
                    let databaseValue = conflict.databaseObject?.value(forKey: key)
                    let contextValue = conflictingObject.value(forKey: key)

                    guard keepingProperties.shouldKeepProperty(
                        key,
                        databaseValue: databaseValue,
                        contextValue: contextValue
                    ) else {
                        continue
                    }

                    conflictingObject.setValue(databaseValue, forKey: key)
                }
            }
        }

        try super.resolve(constraintConflicts: list)
    }
}

extension NSMergePolicy {
    public class var conditionalPropertyOverwriting: ConditionalPropertyOverwritingMergePolicy {
        return ConditionalPropertyOverwritingMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
    }
}
