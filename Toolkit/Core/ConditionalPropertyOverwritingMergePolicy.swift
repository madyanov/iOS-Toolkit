//
//  ConditionalPropertyOverwritingMergePolicy.swift
//  Toolkit
//
//  Created by Roman Madyanov on 11/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import CoreData

public protocol PropertiesKeeping {
    func shouldKeepProperty(_ property: String, with value: Any?) -> Bool
}

public final class ConditionalPropertyOverwritingMergePolicy: NSMergePolicy {
    override public func resolve(constraintConflicts list: [NSConstraintConflict]) throws {
        for conflict in list {
            for conflictingObject in conflict.conflictingObjects {
                guard let propertiesKeeping = conflictingObject as? PropertiesKeeping else {
                    continue
                }

                for key in conflictingObject.entity.attributesByName.keys {
                    let value = conflict.databaseObject?.value(forKey: key)

                    guard propertiesKeeping.shouldKeepProperty(key, with: value) else {
                        continue
                    }

                    conflictingObject.setValue(value, forKey: key)
                }
            }
        }

        try super.resolve(constraintConflicts: list)
    }
}

public extension NSMergePolicy {
    class var conditionalPropertyOverwriting: ConditionalPropertyOverwritingMergePolicy {
        return ConditionalPropertyOverwritingMergePolicy(merge: .mergeByPropertyObjectTrumpMergePolicyType)
    }
}
