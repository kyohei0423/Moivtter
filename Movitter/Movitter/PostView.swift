//
//  PostView.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/29.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit
import AVFoundation

class PostView: UIView {

    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var playMovieView: UIView!
    
    var player: AVPlayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setCommentLabel(8, height: 30)
        setCommentTextView(8, height: 150)
        setPlayMovieView(8)
    }
    
    func drawMovieView(selectedAssets: AVAsset) {
        let playerItem           = AVPlayerItem(asset: selectedAssets)
        player                   = AVPlayer(playerItem: playerItem)
        let playerLayer          = AVPlayerLayer()
        playerLayer.player       = player
        playerLayer.frame        = playMovieView.bounds
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        playMovieView.layer.addSublayer(playerLayer)

        startPlayer()
    }
    
    private func setCommentLabel(margin: CGFloat, height: CGFloat) {
        commentLabel.frame.origin = CGPoint(x: margin, y: margin)
        let width                 = self.frame.width - margin * 2
        commentLabel.frame.size   = CGSize(width: width, height: height)
        commentLabel.text!        = "コメント（必須）"
    }
    
    private func setCommentTextView(margin: CGFloat, height: CGFloat) {
        let y = margin * 2 + commentLabel.frame.height
        commentTextView.frame.origin      = CGPoint(x: margin, y: y)
        let width                         = self.frame.width - margin * 2
        commentTextView.frame.size        = CGSize(width: width, height: height)
        commentTextView.layer.borderWidth = 1
    }
    
    private func setPlayMovieView(margin: CGFloat) {
        let y                      = margin * 4 + commentLabel.frame.height + commentTextView.frame.height
        playMovieView.frame.origin = CGPoint(x: margin, y: y)
        let length                 = self.frame.width - margin * 2
        playMovieView.frame.size   = CGSize(width: length, height: length)
        print(playMovieView.frame)
    }
    
    private func startPlayer() {
        player!.seekToTime(CMTimeMakeWithSeconds(0, Int32(NSEC_PER_SEC)))
        player!.play()
    }
}
