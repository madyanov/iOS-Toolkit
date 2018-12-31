//
//  Model.swift
//  Toolkit
//
//  Created by Roman Madyanov on 18/11/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import Foundation
import CoreData

public protocol Model {
    associatedtype Response: Codable
    associatedtype Entity: NSManagedObject

    init(from: Response)
    init(from: Entity)

    @discardableResult
    func fill(entity: Entity, for: NSManagedObjectContext) -> Entity
    @discardableResult
    func propagate(entity: Entity, for: NSManagedObjectContext) -> Entity

    mutating func merge(_: Self)
}

extension Model {
    public mutating func merge(_ model: Self) { }

    @discardableResult
    public func propagate(entity: Entity, for context: NSManagedObjectContext) -> Entity {
        entity.willChangeValues()
        fill(entity: entity, for: context)
        entity.didChangeValues()
        return entity
    }
}

public protocol Identifiable: Equatable {
    associatedtype Identifier: Equatable

    var id: Identifier { get set }
}

extension Identifiable {
    public static func == (left: Self, right: Self) -> Bool {
        return left.id == right.id
    }
}

extension NSManagedObject {
    private var relationships: [String: String] {
        var relationships: [String: String] = [:]
        let className = String(describing: type(of: self))

        for (name, relationship) in entity.relationshipsByName
            where relationship.inverseRelationship?.destinationEntity?.managedObjectClassName == className
        {
            guard let inverseName = relationship.inverseRelationship?.name else {
                continue
            }

            relationships[name] = inverseName
        }

        return relationships
    }

    public func willChangeValues() {
        for (name, inverseName) in relationships {
            let relationshipObject = value(forKey: name) as? NSManagedObject
            relationshipObject?.willChangeValue(forKey: inverseName)
            relationshipObject?.willChangeValues()
        }
    }

    public func didChangeValues() {
        for (name, inverseName) in relationships {
            let relationshipObject = value(forKey: name) as? NSManagedObject
            relationshipObject?.didChangeValue(forKey: inverseName)
            relationshipObject?.didChangeValues()
        }
    }
}
