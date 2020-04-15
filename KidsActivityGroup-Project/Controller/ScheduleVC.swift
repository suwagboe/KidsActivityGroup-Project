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
    
    
      override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
      }
      private func configureCollectionView()  {
        collectionView.dataSource = self
        collectionView.delegate = self
      }
    }

extension ScheduleVC: UICollectionViewDataSource  {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
      }
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scheduleCell", for: indexPath)
        cell.backgroundColor = .systemTeal
        return cell
      }
    }
    extension ScheduleVC: UICollectionViewDelegateFlowLayout  {
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

  
