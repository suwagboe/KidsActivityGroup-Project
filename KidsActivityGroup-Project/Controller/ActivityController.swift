//
//  ActivityController.swift
//  KidsActivityGroup-Project
//
//  Created by Pursuit on 4/14/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit
import Firebase

protocol TransferSelectedActivites: AnyObject {
    // needs to take in the type from coreData
    //addActivityToFirstController(_ ActiveController: ActitivyController, Seleteactivity: CDActivity)
    func addActivityToFirstController(_ ActiveController: ActivityController, Seleteactivity: CDActivity)
}

class ActivityController: UIViewController {
    // collection View
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: TransferSelectedActivites?
    
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
        cell.backgroundColor = .purple
        return cell
    }
    
}

extension ActivityController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let maxSize: CGSize = UIScreen.main.bounds.size
        let spacingBtw: CGFloat = 10.0
        let numOfItems: CGFloat = 2.0
        let itemHeight: CGFloat = maxSize.height * 0.45
        
    
        let maxWidth = maxSize.width
        
          let totalSpacing: CGFloat = numOfItems * CGFloat(spacingBtw)
        
            let itemWidth = (maxWidth - totalSpacing) / numOfItems
        
           return CGSize(width: itemWidth, height: itemHeight)
         }
         func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
         }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let activityChoosenFromActivityControl = activityList[indexPath.row]
        print("I clicked this one: \(activityChoosenFromActivityControl)")
        
        // where I get create the core data type
      
        
        let activityToBeCreated = CoreDataManager.shared.createActivity(imageData: nil, videoURL: nil, id: activityChoosenFromActivityControl.id , title: activityChoosenFromActivityControl.title, description: activityChoosenFromActivityControl.description)
        
        
        // pass the core data type through the delegate
        delegate?.addActivityToFirstController(self, Seleteactivity: activityToBeCreated)
        
        // we are gonna automatically segue to the list controller once they click one
        
                
    // confetti for when item is selected
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return collectionView.indexPathsForSelectedItems?.count ?? 0 <=  4
    }
}




