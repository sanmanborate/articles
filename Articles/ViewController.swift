//
//  ViewController.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let articleViewModel = ArticleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        articleViewModel.delegate = self
        articleViewModel.fetchArticles()
        // Do any additional setup after loading the view.
    }

}

extension ViewController: ArticleViewModelDelegate {
    func didFetchArticleAt(page: Int, count: Int) {
        print("page : \(page) count : \(count)")
    }
    
    func didFailWith(error: String) {
        print("error : \(error)")
    }
    
}
