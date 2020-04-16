//
//  ActivityController.swift
//  KidsActivityGroup-Project
//
//  Created by Pursuit on 4/14/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit
import Firebase

protocol TransferTwoFirstController {
    func sendActivityTwoFirstController()
}

class ActivityController: UIViewController {
    
    // collection View
    @IBOutlet weak var tableView: UITableView!
    
 //   private let databaseService = DatabaseService()

    private var activityList = [Activity](){
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        tableView.dataSource = self
        tableView.delegate = self
        loadActivites()
    }
    
    
    private func loadActivites() {
        // do we want the activites to disappear after they add it
     DatabaseService.shared.fetchActivities(completion: {
            [weak self]
            (result) in
            switch result {
            case .failure:
                break
            case .success(let activities):
                self?.activityList = activities
            }
        })
    }
    
    
}

extension ActivityController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         activityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath)
                   
        let seletect = activityList[indexPath.row]
        
        cell.textLabel?.text = seletect.title
        cell.detailTextLabel?.text = seletect.description
        
        return cell
    }
}

extension ActivityController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}



