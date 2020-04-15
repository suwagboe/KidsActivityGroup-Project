//
//  DatabaseService.swift
//  KidsActivityGroup-Project
//
//  Created by Gregory Keeley on 4/14/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

class DatabaseService {
    static let activitiesCollection = "activities"
    
    private let db = Firestore.firestore()
    private init() {}
    static let shared = DatabaseService()
    
    public func fetchActivities(completion: @escaping (Result<[Activity], Error>) -> ()) {
        db.collection(DatabaseService.activitiesCollection).getDocuments {
            (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let activities = snapshot.documents.compactMap { Activity($0.data()) }
                completion(.success(activities))
            }
        }
    }
}
