//
//  CollectionMovieViewController.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/16.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit
import AVFoundation

class CollectionMovieViewController: UIViewController, UICollectionViewDelegate {

    let collectionMovieViewModel = CollectionMovieViewModel()
    var selectedAssets: AVAsset!

    override func loadView() {
        super.loadView()
        view = UINib.instantiateFirstView("CollectionMovieView")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let collectionMovieView = view as! CollectionMovieView
        collectionMovieView.movieCollectionView.delegate = self
        collectionMovieView.movieCollectionView.dataSource = collectionMovieViewModel
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionMovieViewModel.checkAuthorization(setUpCameraroll)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpCameraroll(result: Bool) {
        if result {
            let queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL)
            let dispatchGroup = dispatch_group_create()
            dispatch_group_async(dispatchGroup, queue, { 
                self.collectionMovieViewModel.getMovies()
            })
            dispatch_group_async(dispatchGroup, queue, { 
                self.collectionMovieViewModel.changeAsset({
                    dispatch_async(dispatch_get_main_queue(), { 
                        let collectionMovieView = self.view as! CollectionMovieView
                        collectionMovieView.movieCollectionView.reloadData()
                    })
                })
            })
        } else {
            moveSettingApp()
        }
    }

    private func moveSettingApp() {
        let alertController = UIAlertController(title: "カメラロールへのアクセスが許可されていません", message: "設定アプリからカメラロールへのアクセスを許可してください", preferredStyle: .Alert)
        let action = UIAlertAction(title: "設定する", style: .Default) { (_) in
            let settingURL = NSURL(string: UIApplicationOpenSettingsURLString)
            if let settingURL = settingURL {
                UIApplication.sharedApplication().openURL(settingURL)
            }
        }
        alertController.addAction(action)
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    //delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedAssets = self.collectionMovieViewModel.avAssets[indexPath.row]
        let collectionMovieView = self.view as! CollectionMovieView
        collectionMovieView.drawMovieView(selectedAssets!)
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
