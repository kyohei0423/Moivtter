//
//  UIAlertController.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/06/02.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    class func moveSetting(title: String) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: "設定アプリからカメラへのアクセスを許可してください", preferredStyle: .Alert)
        let action = UIAlertAction(title: "設定する", style: .Default) { (_) in
            let settingURL = NSURL(string: UIApplicationOpenSettingsURLString)
            if let settingURL = settingURL {
                UIApplication.sharedApplication().openURL(settingURL)
            }
        }
        alertController.addAction(action)
        return alertController
    }
    
    class func errorAlert(message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "エラー", message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
