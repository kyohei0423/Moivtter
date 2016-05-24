//
//  UICollectionViewFlowLayout+Extension.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/16.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewFlowLayout {
    func setCollectionViewLayout(frameWidth: CGFloat, columns: CGFloat) {
        let itemLength = frameWidth / columns
        itemSize = CGSize(width: itemLength, height: itemLength)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
}
