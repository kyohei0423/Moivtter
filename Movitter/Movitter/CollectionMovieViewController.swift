//
//  CollectionMovieViewController.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/16.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit
import AVFoundation
import Async

class CollectionMovieViewController: UIViewController, UICollectionViewDelegate {

    let collectionMovieViewModel = CollectionMovieViewModel()
    var selectedAsset: AVAsset!

    override func loadView() {
        super.loadView()
        view = UINib.instantiateFirstView("CollectionMovieView")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(CollectionMovieViewController.tapNextButton))
        
        let collectionMovieView = view as! CollectionMovieView
        collectionMovieView.movieCollectionView.delegate = self
        collectionMovieView.movieCollectionView.dataSource = collectionMovieViewModel
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setTabBar()
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
            Async.background {
                self.collectionMovieViewModel.getMovies()
            }.background {
                self.collectionMovieViewModel.changeAsset({
                    Async.main {
                        let collectionMovieView = self.view as! CollectionMovieView
                        collectionMovieView.movieCollectionView.reloadData()
                    }
                })
            }
        } else {
            moveSettingApp()
        }
    }
    
    func tapNextButton() {
        performSegueWithIdentifier("ShowPostViewController", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        let postVC = segue.destinationViewController as! PostViewController
        postVC.moveet.asset = selectedAsset
    }

    private func setTabBar() {
        self.tabBarController?.tabBar.hidden = false
        self.tabBarController?.tabBar.translucent = false
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
        selectedAsset = self.collectionMovieViewModel.avAssets[indexPath.row]
        let collectionMovieView = self.view as! CollectionMovieView
        collectionMovieView.drawMovieView(selectedAsset!)
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
