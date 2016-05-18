//
//  CollectionMovieViewController.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/16.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit

class CollectionMovieViewController: UIViewController {
    let collectionMovieVIewModel = CollectionMovieVIewModel()
    
    override func loadView() {
        super.loadView()
        view = UINib.instantiateFirstView("CollectionMovieView")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionMovieVIewModel.checkAuthorization(setUpCameraroll)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpCameraroll(result: Bool) {
        if result {
            let collectionMovieView = view as! CollectionMovieView
            collectionMovieVIewModel.getMovies()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
