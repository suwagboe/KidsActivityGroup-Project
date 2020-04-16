//
//  ViewController.swift
//  KidsActivityGroup-Project
//
//  Created by Pursuit on 4/14/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit
import AVKit

class ScheduleVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var plannedActivities = [CDActivity]()   {
        didSet  {
            collectionView.reloadData()
        }
    }
    
    var selectedMedia = CDActivity()
    var selectedCell: ScheduleCell?
    
    private lazy var imagePickerController: UIImagePickerController = {
        let mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)
        let pickerController = UIImagePickerController()
        pickerController.mediaTypes = mediaTypes ?? ["kUTTypeImage"]
        pickerController.delegate = self
        return pickerController
    }()
    
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
        collectionView.reloadData()
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
        let activity = plannedActivities[indexPath.row]
        
        guard let videoURL = activity.videoData?.convertToURL() else {
            return
        }
        let playerViewController = AVPlayerViewController()
        let player = AVPlayer(url: videoURL)
        playerViewController.player = player
        present(playerViewController, animated: true) {
            player.play()
        }
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
    
    func didLongPress(_ scheduleCell: ScheduleCell, activity: CDActivity) {
        
        selectedMedia = activity
        selectedCell = scheduleCell
        
        guard let indexPath = collectionView.indexPath(for: scheduleCell) else {
            return
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        present(alertController, animated: true)
        
        let photoLibrary = UIAlertAction(title: "Media Library", style: .default) { [weak self] alertAction in
            self?.imagePickerController.sourceType = .photoLibrary
            
            guard let imagePicker = self?.imagePickerController else { return }
            self?.present(imagePicker, animated: true)
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default) { [weak self] alertAction in
            self?.imagePickerController.sourceType = .camera
            
            guard let imagePicker = self?.imagePickerController else { return }
            self?.present(imagePicker, animated: true)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
            
            CoreDataManager.shared.deleteActivity(activity: activity)
            self?.plannedActivities.remove(at: indexPath.row)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(camera)
        alertController.addAction(photoLibrary)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
    }
    
    
}


extension ScheduleVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else {
            return
        }
        
        switch mediaType {
        case "public.image":
            if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
                let imageData = originalImage.jpegData(compressionQuality: 1.0){
                
                // add to Core Data
                CoreDataManager.shared.updateActivity(imageData: imageData, videoURL: nil, activity: selectedMedia)
                
            }
        case "public.movie":
            if let mediaURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
                let image = mediaURL.videoPreviewThumbnail(),
                let imageData = image.jpegData(compressionQuality: 1.0){
                print("mediaURL: \(mediaURL)")
                
                CoreDataManager.shared.updateActivity(imageData: imageData, videoURL: mediaURL, activity: selectedMedia)
            }
        default:
            print("unsupported media type")
        }
        
        selectedCell?.configureCell(plannedActivity: selectedMedia)
        
        picker.dismiss(animated: true)
    }
}
