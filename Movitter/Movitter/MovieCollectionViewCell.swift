//
//  MovieCollectionViewCell.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/16.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit
import AVFoundation

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var captureImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layoutCaptureView()
    }
    
    func fillWith(asset: AVAsset) {
//        let imageGenerator = AVAssetImageGenerator(asset: asset)
//        let capturePoint = CMTimeMakeWithSeconds(0.0, 600)
//        do {
//            let captureImage = try imageGenerator.copyCGImageAtTime(capturePoint, actualTime: nil)
//            captureImageView.image = UIImage(CGImage: captureImage)
//        } catch let error {
//            print(error)
//        }
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        let tVal = NSValue(CMTime: CMTimeMake(Int64(0.0), 1))
        
        imageGenerator.generateCGImagesAsynchronouslyForTimes([tVal]) { (_, image, _, _, _) in
            guard let image = image else { return }
            self.captureImageView.image = UIImage(CGImage: image)
        }
    }
    
    private func layoutCaptureView() {
        captureImageView.contentMode = .ScaleAspectFill
    }

}
