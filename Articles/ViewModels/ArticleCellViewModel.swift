//
//  ArticleCellViewModel.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class ArticleCellViewModel {
    
    var userName : String!
    var userDesignation : String!
    var userAvatar : URL!
    var articleImage : URL?
    var articleContent : String!
    var articleTitle : String!
    var articleUrl : URL!
    var likes : String!
    var comments : String!
    var article : Article {
        didSet{
            setUserName()
            setDesignation()
            setUserAvatar()
            setArticleImage()
            setArticleContent()
            setArticleTitle()
            setArticleUrl()
            setArticleLikes()
            setArticleComments()
        }
    }
    
    init(article : Article) {
        self.article = article
    }
    
    func setUserName() {
        userName = ""
        if let name = article.users?.first?.name {
            userName = name
        }
        if let lastname = article.users?.first?.lastname {
            userName = userName + " " + lastname
        }
    }
    
    func setDesignation() {
        userDesignation = ""
        if let designation = article.users?.first?.designation {
            userDesignation = designation
        }
    }
    
    func setUserAvatar() {
        if let avatar = article.users?.first?.avatar {
            userAvatar = avatar
        }
    }
    
    func setArticleImage() {
        if let image = article.media?.first?.image {
            articleImage = image
        }
    }
    
    func setArticleContent() {
        if let content = article.content {
            articleContent = content
        }
    }
    
    func setArticleTitle() {
        if let title = article.media?.first?.title {
            articleTitle = title
        }
    }
    
    func setArticleUrl() {
        if let url = article.media?.first?.url {
            articleUrl = url
        }
    }
    
    func setArticleLikes() {
        let likesCount = article.likes
        if likesCount >= 1000 {
            self.likes = String(format: "%.1fK Likes", (likesCount/1000))
        }
        else {
            self.likes = "\(likesCount) Likes"
        }
    }
    
    func setArticleComments() {
        let commentsCount = article.comments
        if commentsCount >= 1000 {
            self.comments = String(format: "%.1fK Comments", (commentsCount/1000))
        }
        else{
            self.comments = "\(commentsCount) Comments"
        }
        
    }
}
