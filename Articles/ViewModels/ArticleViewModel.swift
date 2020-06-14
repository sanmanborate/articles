//
//  ArticleViewModel.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class ArticleViewModel {
    
    var canGoToNextPage : Bool = true
    var currentPage = 1
    var limit = 10
    var fetchedData : [Article] = []
    var cellViewModels : [ArticleCellViewModel] = []
    
    func fetchNextPage() {
        currentPage = currentPage + 1
    }
    
}
