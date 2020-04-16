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
    @IBOutlet weak var collectionView: UICollectionView!
    
 //   private let databaseService = DatabaseService()

    private var activityList = [Activity](){
        didSet{
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI(){
        collectionView.dataSource = self
        collectionView.delegate = self
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


extension ActivityController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activityList.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCell", for: indexPath) as? ActivityCell else {
            fatalError("couldnt downcast to ActivityCell")
        }
                   
        let seletect = activityList[indexPath.row]
        
        cell.configureCell(for: seletect)
      //  cell.textLabel?.text = seletect.title
      //  cell.detailTextLabel?.text = seletect.description
        
        return cell
    }
    
    
    
}

extension ActivityController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let maxSize: CGSize = UIScreen.main.bounds.size
           let itemWidth: CGFloat = maxSize.width
           let itemHeight: CGFloat = maxSize.height * 0.40
           return CGSize(width: itemWidth, height: itemHeight)
         }
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
         }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}




