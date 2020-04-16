//
//  ConvertDataToURL.swift
//  KidsActivityGroup-Project
//
//  Created by Kelby Mittan on 4/15/20.
//  Copyright © 2020 Pursuit. All rights reserved.
//

import Foundation

extension Data {
    
    public func convertToURL() -> URL? {
        
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("video").appendingPathExtension("mp4")
        do {
            try self.write(to: tempURL, options: [.atomic])
            return tempURL
        } catch {
            print("failed to write (save) video data to temporary file with error: \(error)")
        }
        return nil
    }
}
