//
//  CollectionMovieView.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/16.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit
import AVFoundation

class CollectionMovieView: UIView {

    let flowLayout = UICollectionViewFlowLayout()
    var player: AVPlayer!

    @IBOutlet weak var playMovieView: UIView!
    @IBOutlet weak var movieCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()

        movieCollectionView.registerCell("MovieCollectionViewCell")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        flowLayout.setCollectionViewLayout(self.frame.width, columns: 3)
        movieCollectionView.collectionViewLayout = flowLayout
        collectionViewSettings()
    }
    
    func drawMovieView(selectedAssets: AVAsset) {
        let playerItem = AVPlayerItem(asset: selectedAssets)
        player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer()
        playerLayer.player = player
        playerLayer.frame = playMovieView.bounds
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playMovieView.layer.addSublayer(playerLayer)
        
        startPlayer()
    }
    
    private func startPlayer() {
        player!.seekToTime(CMTimeMakeWithSeconds(0, Int32(NSEC_PER_SEC)))
        player!.play()
    }

    private func collectionViewSettings() {
        self.movieCollectionView.backgroundColor = UIColor.whiteColor()
    }

}
