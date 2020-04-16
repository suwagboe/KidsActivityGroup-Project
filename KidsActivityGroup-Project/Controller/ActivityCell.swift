//
//  ActivityCell.swift
//  KidsActivityGroup-Project
//
//  Created by Pursuit on 4/16/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit


class ActivityCell: UICollectionViewCell {
    
    // static vs public
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var info: UILabel!

    public func configureCell(for activity: Activity){
        
        titleLabel.text = activity.title
        info.text = activity.description
    }
    
}
