//
//  CollectionMovieVIewModel.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/16.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit
import Photos

class CollectionMovieVIewModel: NSObject, UICollectionViewDataSource {
    var movies = [AVAsset]()
    let movieManager = PHImageManager()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
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
        let assets = PHAsset.fetchAssetsWithMediaType(.Video, options: options)
        assets.enumerateObjectsUsingBlock { (asset, index, stop) in
            self.changeAsset(asset as! PHAsset)
        }
    }
    
    //PHAssetからAVAssetに変換
    private func changeAsset(asset: PHAsset) {
        let manager = PHImageManager()
        manager.requestAVAssetForVideo(asset, options: nil) { (avAsset, avAudioMix, info) in
            guard let avAsset =  avAsset else { return }
            self.movies.append(avAsset)
        }
    }
    
    
    //DataSource
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCollectionViewCell", forIndexPath: indexPath) as! MovieCollectionViewCell
        return cell
    }
}
