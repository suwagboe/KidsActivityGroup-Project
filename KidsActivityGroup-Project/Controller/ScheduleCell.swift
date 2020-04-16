//
//  ScheduleCell.swift
//  KidsActivityGroup-Project
//
//  Created by Juan Ceballos on 4/16/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

class ScheduleCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public func configureCell(plannedActivity: CDActivity)    {
        titleLabel.text = plannedActivity.title
        descriptionLabel.text = plannedActivity.description
    }
}
