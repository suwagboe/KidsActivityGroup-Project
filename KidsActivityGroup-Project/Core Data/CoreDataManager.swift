//
//  CoreDataManager.swift
//  KidsActivityGroup-Project
//
//  Created by Kelby Mittan on 4/15/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    private init() {}
    
    static let shared = CoreDataManager()
    
    private var activities = [CDActivity]()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public func createActivity(imageData: Data?, videoURL: URL?, id: String, title: String, description: String) -> CDActivity {
        
        let activity = CDActivity(entity: CDActivity.entity(), insertInto: context)
        
        activity.activityDate = Date()
        activity.id = id
        activity.activityDescription = description
        activity.title = title
        
        activity.imageData = imageData
        
        if let videoURL = videoURL {
            do {
                activity.videoData = try Data(contentsOf: videoURL)
            } catch {
                print("failed to convert URL to Data with error: \(error)")
            }
        }
        
        do {
            try context.save()
        } catch {
            print("failed to save activity with error: \(error)")
        }
        
        return activity
    }
    
    public func fetchActivities() -> [CDActivity] {
        
        do {
            activities = try context.fetch(CDActivity.fetchRequest())
        } catch {
            print("failed to fetch activities with: \(error)")
        }
        return activities
        
    }
    
    public func updateActivity(imageData: Data, videoURL: URL?, activity: CDActivity) {
        
        activity.setValue(imageData, forKey: "imageData")
        
        if let videoURL = videoURL {
            do {
                activity.setValue(try Data(contentsOf: videoURL), forKey: "videoData")
            } catch {
                print("failed to convert URL to Data with error: \(error)")
            }
        }
        
        do {
            try context.save()
        } catch {
            print("failed to save activity with error: \(error)")
        }
    }

}
