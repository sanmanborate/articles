//
//  RestClient.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
typealias CompletionHandler = (Bool, Data?, Error?) -> Void

class RestClient {
    var session = URLSession(configuration: URLSessionConfiguration.default)
    
    func get(url : URL, headers : [String:String] = [:] ,callback : @escaping CompletionHandler) {
        let urlRequest = URLRequest(url: url)
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            callback(data == nil, data, error)
        }
        task.resume()
    }
}
