//
//  ArticleManager.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
protocol ArticleManagerDelegate {
    func didFetchaArticles(articles : [Article], at page: Int)
    func didFailToFetchArticle(at page: Int, error: Error?)
}

enum ArticleManagerError : Error {
    case noData
}

class ArticleManager {
    let apiClient = APIClient()
    let syncManager = SyncManager()
    var delegate : ArticleManagerDelegate?
    
    var isReachable : Bool{
        true
    }
    
    func getArticlesAt(page: Int, limit: Int) {
        if isReachable {
            apiClient.getArticleAtPage(number: page, limit: limit) { [weak self] (success, data, error) in
                if let strongSelf = self {
                    if success,let data = data {
                        let articles = strongSelf.syncManager.syncArticlesWith(data: data)
                        if (articles.count == 0){
                            strongSelf.delegate?.didFailToFetchArticle(at: page, error: ArticleManagerError.noData)
                            return
                        }
                        strongSelf.delegate?.didFetchaArticles(articles: articles, at: page)
                    }
                    else {
                        strongSelf.delegate?.didFailToFetchArticle(at: page, error: error)
                    }
                }
            }
        }
        else {
            let articles = syncManager.fetchArticlesAt(pageNumber: page, limit: limit)
            if (articles.count == 0){
                delegate?.didFailToFetchArticle(at: page, error: ArticleManagerError.noData)
                return
            }
            delegate?.didFetchaArticles(articles: articles, at: page)
        }
    }
}
