//
//  MovieListView.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/01.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit

class MovieListView: UIView {
    @IBOutlet weak var movieListTableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieListTableView.registerCell("MovieListTableViewCell")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let nib = UINib(nibName: "MovieListTableViewCell", bundle: nil)
        movieListTableView.registerNib(nib, forCellReuseIdentifier: "MovieListTableViewCell")
    }
}