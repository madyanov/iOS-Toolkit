//
//  CoreData.swift
//  Toolkit
//
//  Created by Roman Madyanov on 23/09/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import CoreData

public final class CoreData
{
    public enum StorageType
    {
        case sqLite
        case inMemory
        case binary

        var rawValue: String {
            switch self {
            case .sqLite:   return NSSQLiteStoreType
            case .inMemory: return NSInMemoryStoreType
            case .binary:   return NSBinaryStoreType
            }
        }
    }

    public enum ContainerType
    {
        case local
        case cloudKit(containerIdentifier: String)
    }

    public let modelName: String
    public let storageType: StorageType
    public let containerType: ContainerType

    public lazy var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription(url: url)
        description.type = storageType.rawValue

        let container: NSPersistentContainer

        if #available(iOS 13.0, *), case .cloudKit(let containerIdentifier) = containerType {
            container = NSPersistentCloudKitContainer(name: modelName)
            description.cloudKitContainerOptions =
                NSPersistentCloudKitContainerOptions(containerIdentifier: containerIdentifier)
        } else {
            container = NSPersistentContainer(name: modelName)
            print("!!! CoreData: fallback to local persistent container")
        }

        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { [weak self] _, error in
            if let error = error {
                print("!!! CoreData Error: \(error.localizedDescription)")
            } else {
                container.viewContext.automaticallyMergesChangesFromParent = true
            }

            self?.completion?(error)
        }

        return container
    }()

    public lazy var viewContext = persistentContainer.viewContext

    private lazy var dispatchQueue = DispatchQueue(label: "com.madyanov.Toolkit.CoreData")

    private let completion: ((Error?) -> Void)?
    private let url: URL

    public init(modelName: String = Bundle.main.bundleIdentifier?.components(separatedBy: ".").last ?? "",
                storageType: StorageType = .sqLite,
                containerType: ContainerType = .local,
                completion: ((Error?) -> Void)? = nil)
    {
        self.modelName = modelName
        self.storageType = storageType
        self.containerType = containerType
        self.completion = completion

        url = CoreData.url(for: modelName)
        print("SQLite database path: \(url.path)")
    }

    public func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        dispatchQueue.async {
            let context = self.persistentContainer.newBackgroundContext()

            context.performAndWait {
                block(context)
            }
        }
    }
}

extension CoreData
{
    private class func url(for modelName: String) -> URL {
        let fileName = "\(modelName).sqlite"
        let fileManager = FileManager.default

        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return NSPersistentContainer.defaultDirectoryURL().appendingPathComponent(fileName)
        }

        return documentDirectory.appendingPathComponent(fileName)
    }
}
