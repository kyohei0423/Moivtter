//
//  MovieManager.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/05.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class MovieManager: NSObject {
    //データの入力と出力を管理する
    var session: AVCaptureSession?
    //使用するデバイスを指定（フロントカメラ・バックカメラ）
    var device: AVCaptureDevice?
    //データの入力を行う
    var input: AVCaptureInput?
    //データの出力を行う
    var output: AVCaptureMovieFileOutput?
    //レコード中かどうか
    var isRecording = false

    //カメラロールへのアクセスの許可の有無を確認する
    func checkAuthorization(callback: Bool -> ()) {
        switch AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) {
        case .Authorized:   //許可
            callback(true)
        case .Denied, .Restricted:  //アプリ自体が不許可の場合、ユーザーによって不許可にされた場合
            callback(false)
        case .NotDetermined:    //どちらも選択していない場合
            requestAccessToCamera()
        }
    }

    func begin() {
        session?.startRunning()
    }

    func stop() {
        session?.stopRunning()
    }
    
    func recordOrStop(delegate: AVCaptureFileOutputRecordingDelegate) {
        guard let output = output else { return }
        if isRecording {
            //録画を停止する
            output.stopRecording()
            //録画中でなくする
            isRecording = false
        } else {
            let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentsDirectory = path[0]
            let filePath: String = "\(documentsDirectory)/temp.mp4"
            let fileURL: NSURL = NSURL(fileURLWithPath: filePath)
            output.startRecordingToOutputFileURL(fileURL, recordingDelegate: delegate)
            //録画中にする
            isRecording = true
        }
    }

    func finishRecord(outputFile: NSURL) {
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({ () -> Void in
            let list = PHAssetCollection.fetchAssetCollectionsWithType(PHAssetCollectionType.Album, subtype: PHAssetCollectionSubtype.Any, options: nil)
            var assetAlbum = PHAssetCollection()

            list.enumerateObjectsUsingBlock { (album, index, isStop) -> Void in
                if album.localizedTitle == "video" {
                    assetAlbum = album as! PHAssetCollection
                    isStop.memory = true
                }
            }
            let result = PHAssetChangeRequest.creationRequestForAssetFromVideoAtFileURL(outputFile)
            let assetPlaceholder = result?.placeholderForCreatedAsset
            let saveAlbum = PHAssetCollectionChangeRequest(forAssetCollection: assetAlbum)
            saveAlbum?.addAssets([assetPlaceholder] as! NSFastEnumeration)
        }) { (success, error) -> Void in
            guard success else {
                print(error)
                return
            }
        }
    }


    private func requestAccessToCamera() {
        AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (success) -> Void in
            self.setUPCamera()
        })
    }

    func setUPCamera() {
        device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do {
            session = AVCaptureSession()
            if let session = session {
                session.beginConfiguration()
                input = try AVCaptureDeviceInput.init(device: device)
                session.addInput(input)
                output = AVCaptureMovieFileOutput()
                session.addOutput(output)
                session.commitConfiguration()
            }
        } catch let error as NSError {
            print(error)
            session = nil
        }
    }
}
