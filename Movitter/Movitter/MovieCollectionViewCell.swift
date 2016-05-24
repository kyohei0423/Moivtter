//
//  MovieCollectionViewCell.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/16.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var captureImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    func fillWith(asset: AVAsset) {
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        let capturePoint = CMTimeMakeWithSeconds(0.0, 600)
        do {
            let captureImage = try imageGenerator.copyCGImageAtTime(capturePoint, actualTime: nil)
            captureImageView.image = UIImage(CGImage: captureImage)
        } catch let error {
            print(error)
        }
    }
        captureImageView.contentMode = .ScaleAspectFill
    }

}
