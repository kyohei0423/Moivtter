//
//  UICollectionView+Extension.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/16.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {

    func registerCell(cellName: String) {
        let nib = UINib(nibName: cellName, bundle: nil)
        registerNib(nib, forCellWithReuseIdentifier: cellName)
    }
}
