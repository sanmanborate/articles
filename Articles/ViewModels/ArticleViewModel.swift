//
//  ArticleViewModel.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

protocol ArticleViewModelDelegate  {
    func didStartFetching()
    func didFetchArticleAt(page :Int, count:Int)
    func didFailWith(error: String)
}

class ArticleViewModel {
    
    let articleManager = ArticleManager()
    var delegate : ArticleViewModelDelegate?
    
    var canGoToNextPage : Bool = true
    var currentPage = 1
    var limit = 10
    var fetchedData : [Article] = []
    var cellViewModels : [ArticleCellViewModel] = []
    var isFetching : Bool = false
    
    init() {
        articleManager.delegate = self
    }
    
    func fetchNextPage() {
        if !isFetching {
            isFetching = true
            currentPage = currentPage + 1
            fetchArticles()
        }
        else {
            print("already fetching")
        }
    }
    
    func fetchArticles() {
        isFetching = true
        delegate?.didStartFetching()
        articleManager.getArticlesAt(page: currentPage, limit: limit)
    }
}

extension ArticleViewModel : ArticleManagerDelegate {
    func didFetchaArticles(articles: [Article], at page: Int) {
        isFetching = false
        fetchedData.append(contentsOf: articles)
        let cellVMs = articles.map { (article) -> ArticleCellViewModel in
            ArticleCellViewModel(article: article)
        }
        cellViewModels.append(contentsOf: cellVMs)
        delegate?.didFetchArticleAt(page: page, count: articles.count)
    }
    
    func didFailToFetchArticle(at page: Int, error: Error?) {
        isFetching = false
        if let error = error as? ArticleManagerError, error == ArticleManagerError.noData {
            delegate?.didFailWith(error: "No more data")
        }
    }
}
