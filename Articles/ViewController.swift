//
//  ViewController.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activittIndicator: UIActivityIndicatorView!
    let articleViewModel = ArticleViewModel()
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVM()
        setupArticleTableView()
        // Do any additional setup after loading the view.
    }
    
    func setupVM() {
        articleViewModel.delegate = self
        articleViewModel.fetchArticles()
    }
    
    func setupArticleTableView() {
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: .main)
        tableview.tableFooterView = UIView(frame: CGRect.zero)
        tableview.register(nib, forCellReuseIdentifier: "cell")
        tableview.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articleViewModel.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ArticleTableViewCell
        cell.setupWith(vm: articleViewModel.cellViewModels[indexPath.row])
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset - currentOffset <= 1.0 {
            print("requesting next page")
            articleViewModel.fetchNextPage()
        }
    }
}

extension ViewController: ArticleViewModelDelegate {
    func didStartFetching() {
        activittIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func didFetchArticleAt(page: Int, count: Int) {
        DispatchQueue.main.async {
            self.enableUserInteraction()
            self.tableview.reloadData()
        }
    }
    
    func didFailWith(error: String) {
        DispatchQueue.main.async {
            self.enableUserInteraction()
        }
        print("error : \(error)")
    }
    
    func enableUserInteraction() {
        self.activittIndicator.stopAnimating()
        self.view.isUserInteractionEnabled = true
    }
    
}
