//
//  ViewController.swift
//  KidsActivityGroup-Project
//
//  Created by Pursuit on 4/14/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class ScheduleVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var plannedActivities = [CDActivity]()   {
        didSet  {
            collectionView.reloadData()
        }
    }
    
    // refactor to CoreDataObject with title description nil image
    // update when selected to add image to CDObject stored
    // a cdactivity is created each time activity selected
    // when this page loads fectchCDActivities, reload collectionview
    // set things in items appropriately
    // when item longpressed open camera
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        plannedActivities = CoreDataManager.shared.fetchActivities()
    }
    
    private func configureCollectionView()  {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension ScheduleVC: UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plannedActivities.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scheduleCell", for: indexPath) as? ScheduleCell
            else    {
                fatalError()
        }

        cell.backgroundColor = .systemTeal
        let activity = plannedActivities[indexPath.row]
        cell.scheduleDelegate = self
        cell.currentActivity = activity
        cell.configureCell(plannedActivity: activity)
        return cell
    }
    
}

extension ScheduleVC: UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("pressed a cell \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width
        let itemHeight: CGFloat = maxSize.height * 0.40
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension ScheduleVC: ScheduleCellDelegate {
    
    func didLongPress(_ imageCell: ScheduleCell, activity: CDActivity) {
        print(activity.id ?? "error")
    }
    
    
}
