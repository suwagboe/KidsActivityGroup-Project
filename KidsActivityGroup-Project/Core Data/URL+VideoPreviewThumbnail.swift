//
//  URL+VideoPreviewThumbnail.swift
//  KidsActivityGroup-Project
//
//  Created by Kelby Mittan on 4/16/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import UIKit
import AVFoundation

extension URL {
    
    public func videoPreviewThumbnail() -> UIImage? {
        let asset = AVAsset(url: self)
        
        let assetGenerator = AVAssetImageGenerator(asset: asset)
        
        assetGenerator.appliesPreferredTrackTransform = true
        
        let timestamp = CMTime(seconds: 1, preferredTimescale: 60)
        
        var image: UIImage?
        
        do {
            let cgImage = try assetGenerator.copyCGImage(at: timestamp, actualTime: nil)
            image = UIImage(cgImage: cgImage)
        } catch {
            print("failed to generate image: \(error)")
        }
        return image
    }
}
