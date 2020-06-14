//
//  SyncManager.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import CoreData

class SyncManager {
    
    let persistentContainer = CoreDataStack.shared.persistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init() {}
    
    func syncArticlesWith(data: Data) -> [Article] {
        do {
            if let decoded = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]{
                //find ids of new records
                let ids = decoded.compactMap { $0["id"] as? String }
                //create a backgorundContext for operations
                let taskContext = persistentContainer.newBackgroundContext()
                taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                
                do {
                    try batchDeleteArticle(with: ids, taskContext: taskContext)
                    try saveArticles(withData: data, taskContext: taskContext)
                    return fetchArticlesAt()
                } catch {
                    print("Error: \(error)\nCould not batch delete existing records.")
                }
                taskContext.reset()
            }
        }
        return []
    }
    
    func batchDeleteArticle(with ids: [String], taskContext: NSManagedObjectContext) throws  {
        //create article fetch request with article & ids of new records
        let fetchrequest = NSFetchRequest<Article>(entityName: "Article")
        let predicate = NSPredicate(format: "id IN %@", ids)
        fetchrequest.predicate = predicate
        //assign fetch request to batch delete request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchrequest as! NSFetchRequest<NSFetchRequestResult>)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult
        
        if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs],
                                                into: [persistentContainer.viewContext])
        }
    }
    
    func saveArticles(withData :Data, taskContext: NSManagedObjectContext) throws {
        let decoder = JSONDecoder()
        decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = taskContext
        decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
        let _ = try decoder.decode([Article].self, from: withData)
        try taskContext.save()
    }
    
    func fetchArticlesAt(pageNumber: Int = 1, limit: Int = 10) -> [Article] {
        let fetchRequest = NSFetchRequest<Article>(entityName: "Article")
        fetchRequest.fetchOffset = (pageNumber - 1)*limit
        fetchRequest.fetchLimit = limit
        do {
            let articles = try viewContext.fetch(fetchRequest)
            return articles
        } catch  {
            print("Error: \(error)\nCould not fetch existing records.")
        }
        return []
    }
}
