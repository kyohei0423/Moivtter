//
//  PostViewController.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/29.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    let moveet = Moveet()
    
    override func loadView() {
        super.loadView()
        view = UINib.instantiateFirstView("PostView")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let movitterTabBarController = self.tabBarController as! MovitterTabBarController
        movitterTabBarController.hideTabBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let postView = view as! PostView
        postView.drawMovieView(moveet.asset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapBackButton() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func tapPostButton() {
        let postView = view as! PostView
        moveet.text = postView.commentTextView.text
        print(postView.commentTextView.text)
        if moveet.validation() {
            moveet.save({ 
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        } else {
            showAlert()
        }
    }
    
    private func setNavigationItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .Plain, target: self, action: #selector(PostViewController.tapBackButton))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .Plain, target: self, action: #selector(PostViewController.tapPostButton))
    }
    
    private func showAlert() {
        let alertVC = UIAlertController(title: "エラー", message: "コメントが入力されていません", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertVC.addAction(action)
        self.presentViewController(alertVC, animated: true, completion: nil)
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
