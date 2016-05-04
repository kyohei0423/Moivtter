//
//  TableView+Extension.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/04.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell(cellName: String) {
        let nib = UINib(nibName: cellName, bundle: nil)
        registerNib(nib, forCellReuseIdentifier: cellName)
    }
}
