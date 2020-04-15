//
//  ActivityController.swift
//  KidsActivityGroup-Project
//
//  Created by Pursuit on 4/14/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

protocol TransferTwoFirstController {
    func sendActivityTwoFirstController()
}

class ActivityController: UIViewController {
    
    // collection View
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var activityList = [String](){
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
    }
    
    
    
}

extension ActivityController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activityList.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "activityCell", for: indexPath)
             
             return cell
    }
    
    
}

extension ActivityController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // which ever cell they click on will then be sequed to the first view controller as an option to edit
        
        
        
    }
    
}
