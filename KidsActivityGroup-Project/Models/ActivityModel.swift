//
//  ActivityModel.swift
//  KidsActivityGroup-Project
//
//  Created by Gregory Keeley on 4/14/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import Foundation
import Firebase

struct Activity {
    let id: String
    let title: String
    let description: String
}

extension Activity {
    init?(_ dictionary: [String : Any]) {
        guard let title = dictionary["title"] as? String,
            let description = dictionary["description"] as? String,
        let id = dictionary["id"] as? String
        else {
                return nil
        }
        self.title = title
        self.description = description
        self.id = id
    }
}
