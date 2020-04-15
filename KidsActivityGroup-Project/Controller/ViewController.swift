//
//  ViewController.swift
//  KidsActivityGroup-Project
//
//  Created by Pursuit on 4/14/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        DatabaseService.shared.fetchActivities { (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let activities):
                print(activities.count)
                dump(activities)
            }
            
        }
    }


}

