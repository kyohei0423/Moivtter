//
//  MovieListViewController.swift
//  Movitter
//
//  Created by Seo Kyohei on 2016/05/01.
//  Copyright © 2016年 Kyohei Seo. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, UITableViewDelegate {
    
    override func loadView() {
        let nib = UINib(nibName: "MovieListView", bundle: nil)
        view = nib.instantiateWithOwner(nil, options: nil).first as! MovieListView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Post", style: .Plain, target: self, action: #selector(MovieListViewController.tapPostButton))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let movieListView = view as! MovieListView
        movieListView.movieListTableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tapPostButton() {
        performSegueWithIdentifier("ModalSelectMovieViewController", sender: nil)
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
