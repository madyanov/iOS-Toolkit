//
//  Storage.swift
//  Toolkit
//
//  Created by Roman Madyanov on 23/09/2018.
//  Copyright © 2018 Roman Madyanov. All rights reserved.
//

import CoreData

open class Storage
{
    public let coreData: CoreData

    public init(coreData: CoreData) {
        self.coreData = coreData
    }
}
