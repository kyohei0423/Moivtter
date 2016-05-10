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
    var movieManager: MovieManager!
    
    override func loadView() {
        super.loadView()
        view = UINib.instantiateFirstView("TakeMovieView")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let takeMovieView = view as! TakeMovieView
        takeMovieView.recordButton.addTarget(self, action: #selector(TakeMovieViewController.tapRecordButton), forControlEvents: .TouchUpInside)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        isRecording = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        movieManager = MovieManager()
        movieManager.checkAuthorization(setUpCameraOrShowAlert)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpCameraOrShowAlert(result: Bool) {
        if result {
            let takeMovieView = view as! TakeMovieView
            movieManager.setUPCamera()
            if let session = movieManager.session {
                takeMovieView.drawCaptureView(session)
                movieManager.begin()
            }
        } else {
            moveSettingApp()
        }
    }
    
    func tapRecordButton() {
        let takeMovieView = view as! TakeMovieView
        guard let output = movieManager.output else { return }
        if !isRecording {
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentsDirectory = path[0]
            let filePath: String = "\(documentsDirectory)/temp.mp4"
            let fileURL: NSURL = NSURL(fileURLWithPath: filePath)
            output.startRecordingToOutputFileURL(fileURL, recordingDelegate: self)
            //録画中にする
            isRecording = true
            //ボタンの画像を停止画像にする
            takeMovieView.recordButton.setImage(UIImage(named: "ShutterButtonStop"), forState: .Normal)
        } else {
            //録画を停止する
            output.stopRecording()
            //録画中でなくする
            isRecording = false
            //ボタンの状態を変更する
            takeMovieView.recordButton.setImage(UIImage(named: "ShutterButton1"), forState: .Normal)
        }
    }
    
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        movieManager.finishRecord(outputFileURL)
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
