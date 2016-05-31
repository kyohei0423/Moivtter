//
//  Moveet.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/28.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit
import AVFoundation
import NCMB

class Moveet: NSObject {
    var asset: AVAsset!
    var text: String!
    
    func validation() -> Bool {
        if text.characters.count != 0 {
            return true
        } else {
            return false
        }
    }
    
    func save(callback: () -> Void) {
        let url = asset as! AVURLAsset
        let data = NSData(contentsOfURL: url.URL)
        let file = NCMBFile.fileWithData(data) as! NCMBFile
        let moveetObject = NCMBObject(className: "Moveet")
        moveetObject.setObject(file, forKey: "videoFile")
        moveetObject.setObject(text, forKey: "text")
        moveetObject.saveInBackgroundWithBlock { (error) in
            if error != nil {
                print(error)
            }
            callback()
        }
    }
}
