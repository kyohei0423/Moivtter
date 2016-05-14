//
//  TakeMovieViewController.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/05.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class TakeMovieViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {
    var takeMovieViewModel = TakeMovieViewModel()

    override func loadView() {
        super.loadView()
        view = UINib.instantiateFirstView("TakeMovieView")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let takeMovieView = view as! TakeMovieView
        takeMovieView.recordButton.addTarget(self, action: #selector(TakeMovieViewController.tapRecordButton), forControlEvents: .TouchUpInside)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        takeMovieViewModel.checkAuthorization(setUpCameraOrShowAlert)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpCameraOrShowAlert(result: Bool) {
        if result {
            let takeMovieView = view as! TakeMovieView
            takeMovieViewModel.setUPCamera()
            if let session = takeMovieViewModel.session {
                takeMovieView.drawCaptureView(session)
                takeMovieViewModel.begin()
            }
        } else {
            moveSettingApp()
        }
    }

    func tapRecordButton() {
        let takeMovieView = view as! TakeMovieView
        takeMovieViewModel.recordOrStop(self)
        if takeMovieViewModel.isRecording {
            takeMovieView.recordButton.setImage(UIImage(named: "ShutterButtonStop"), forState: .Normal)
        } else {
            takeMovieView.recordButton.setImage(UIImage(named: "ShutterButton1"), forState: .Normal)
        }
    }

    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        takeMovieViewModel.finishRecord(outputFileURL)
    }


    private func moveSettingApp() {
        let alertController = UIAlertController(title: "カメラへのアクセスが許可されていません", message: "設定アプリからカメラへのアクセスを許可してください", preferredStyle: .Alert)
        let action = UIAlertAction(title: "設定する", style: .Default) { (_) in
            let settingURL = NSURL(string: UIApplicationOpenSettingsURLString)
            if let settingURL = settingURL {
                UIApplication.sharedApplication().openURL(settingURL)
            }
        }
        alertController.addAction(action)
        presentViewController(alertController, animated: true, completion: nil)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
