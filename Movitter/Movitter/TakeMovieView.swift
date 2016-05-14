//
//  TakeMovieView.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/05.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit
import AVFoundation

class TakeMovieView: UIView {

    @IBOutlet weak var captureView: UIView!
    @IBOutlet weak var recordButton: UIButton!
    
    func drawCaptureView(session: AVCaptureSession) {
        let videoPreview = AVCaptureVideoPreviewLayer(session: session)
        videoPreview.frame = captureView.bounds
        videoPreview.videoGravity = AVLayerVideoGravityResizeAspectFill
        captureView.layer.addSublayer(videoPreview)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
