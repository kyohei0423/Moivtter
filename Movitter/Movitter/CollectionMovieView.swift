//
//  CollectionMovieView.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/16.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit

class CollectionMovieView: UIView {

    let flowLayout = UICollectionViewFlowLayout()

    @IBOutlet weak var previewMovieView: UIView!
    @IBOutlet weak var movieCollectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()

        movieCollectionView.registerCell("MovieCollectionViewCell")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        flowLayout.setCollectionViewLayout(self.frame.width)
        collectionViewSettings()
    }

    func collectionViewSettings() {
        self.movieCollectionView.backgroundColor = UIColor.whiteColor()
    }

}
