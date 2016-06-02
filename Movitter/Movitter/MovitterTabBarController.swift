//
//  TabBarController.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/06/01.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit

class MovitterTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showTabBar() {
        self.tabBarController?.tabBar.hidden = false
        self.tabBarController?.tabBar.translucent = false
    }

    func hidTabBar() {
        self.tabBarController?.tabBar.hidden = true
        self.tabBarController?.tabBar.translucent = true
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
