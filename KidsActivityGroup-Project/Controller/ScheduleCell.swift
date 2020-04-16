//
//  ScheduleCell.swift
//  KidsActivityGroup-Project
//
//  Created by Juan Ceballos on 4/16/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit

protocol ScheduleCellDelegate: AnyObject {
    func didLongPress(_ scheduleCell: ScheduleCell, activity: CDActivity)
}

class ScheduleCell: UICollectionViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet var activityImageView: UIImageView!
    
    public var currentActivity: CDActivity?
    
    weak var scheduleDelegate: ScheduleCellDelegate?
    
    private lazy var longPressGesture: UILongPressGestureRecognizer = {
        let gesture = UILongPressGestureRecognizer()
        gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
        return gesture
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addGestureRecognizer(longPressGesture)
    }
    
    public func configureCell(plannedActivity: CDActivity)    {
        
        if plannedActivity.imageData == nil {
            titleLabel.text = plannedActivity.title
            descriptionLabel.text = plannedActivity.activityDescription
        } else {
            descriptionLabel.isHidden = true
            if let imageData = plannedActivity.imageData {
              activityImageView.image = UIImage(data: imageData)
            }
                
            if let videoURL = plannedActivity.videoData?.convertToURL() {
              let image = videoURL.videoPreviewThumbnail() ?? UIImage(systemName: "photo")
              activityImageView.image = image
            }
        }
    }
    
    @objc private func longPressAction(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            gesture.state = .cancelled
            return
        }
        
        guard let activity = currentActivity else {
            fatalError("Failed to retrieve activity")
        }
        
        scheduleDelegate?.didLongPress(self, activity: activity)
    }
}
