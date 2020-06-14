//
//  APIClient.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

enum CustomError: Error {
   case unknownError
   case connectionError
   case invalidCredentials
   case invalidRequest
   case notFound
   case invalidResponse
   case serverError
   case serverUnavailable
   case timeOut
   case unsuppotedURL
}

class APIClient {
    
    var restClient = RestClient()
    
    func getArticlePage(number : Int,ofSize : Int, callback : @escaping CompletionHandler) {
        var components = URLComponents(string: URLHelper.articlesUrl)!
        let parameters = ["page":number, "limit":ofSize]
        components.queryItems = parameters.map { (arg) -> URLQueryItem in
            let (key, value) = arg
            return URLQueryItem(name: key, value: "\(value)")
        }
        
        guard let url = components.url else {
            callback(false, nil, CustomError.unsuppotedURL)
            return
        }
        restClient.get(url: url, callback: callback)
    }
    
}
