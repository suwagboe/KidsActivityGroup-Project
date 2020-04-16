//
//  CDActivity+CoreDataProperties.swift
//  KidsActivityGroup-Project
//
//  Created by Kelby Mittan on 4/15/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//
//

import Foundation
import CoreData


extension CDActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDActivity> {
        return NSFetchRequest<CDActivity>(entityName: "CDActivity")
    }

    @NSManaged public var activityDate: Date?
    @NSManaged public var activityDescription: String?
    @NSManaged public var id: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var videoData: Data?
    @NSManaged public var title: String?

}
