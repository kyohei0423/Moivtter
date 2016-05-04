//
//  UINib+Extension.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/04.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import Foundation
import UIKit

extension UINib {
    class func instantiateFirstView<T: UIView>(name: String) -> T {
        let nib = UINib(nibName: name, bundle: nil)
        return nib.instantiateWithOwner(nil, options: nil).first as! T
    }
}
