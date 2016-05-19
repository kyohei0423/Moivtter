//
//  CollectionMovieVIewModel.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/16.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit
import Photos

class CollectionMovieViewModel: NSObject, UICollectionViewDataSource {
    var phAssets = [PHAsset]()
    var avAssets = [AVAsset]()
    let movieManager = PHImageManager()

    //カメラロールへのアクセスへの許可を確認
    func checkAuthorization(callback: Bool -> ()) {
        switch PHPhotoLibrary.authorizationStatus() {
        case .Authorized:
            callback(true)
        case .Denied, .Restricted:
            callback(false)
        case .NotDetermined:
            PHPhotoLibrary.requestAuthorization({ (status) in
                if status == .Authorized {
                    callback(true)
                }
            })
        }
    }

    //動画を取得
    func getMovies() {
        let options = PHFetchOptions()
        options.sortDescriptors = [
            NSSortDescriptor(key: "creationDate", ascending: false)
        ]
        let fetchResult = PHAsset.fetchAssetsWithMediaType(.Video, options: options)
        fetchResult.enumerateObjectsUsingBlock { (asset, index, stop) in
            self.phAssets.append(asset as! PHAsset)
        }
    }

    //PHAssetからAVAssetに変換し配列に格納
    func changeAsset(callback: Void -> ()) {
        for phAsset in phAssets {
            let manager = PHImageManager()
            manager.requestAVAssetForVideo(phAsset, options: nil) { (avAsset, avAudioMix, info) in
                guard let avAsset =  avAsset else { return }
                self.avAssets.append(avAsset)
                callback()
            }
        }
    }

    //DataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avAssets.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCollectionViewCell", forIndexPath: indexPath) as! MovieCollectionViewCell
        let asset = self.avAssets[indexPath.row]
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        let capturePoint = CMTimeMakeWithSeconds(0.0, 600)
        do {
            let captureImage = try imageGenerator.copyCGImageAtTime(capturePoint, actualTime: nil)
            cell.captureImageView.image = UIImage(CGImage: captureImage)
        } catch let error {
            print(error)
        }
        return cell
    }
}
