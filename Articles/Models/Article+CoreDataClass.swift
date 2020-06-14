//
//  Article+CoreDataClass.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject,Codable {

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt
        case content
        case comments
        case likes
        case media
        case user
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Article", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
        self.comments = try (container.decodeIfPresent(Int32.self, forKey: .comments) ?? 0)
        self.likes = try (container.decodeIfPresent(Int32.self, forKey: .likes) ?? 0)
        self.media = try (container.decodeIfPresent(Set<Media>.self, forKey: .media) ?? Set<Media>())
        self.users = try (container.decodeIfPresent(Set<User>.self, forKey: .user) ?? Set<User>())
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(content, forKey: .content)
        try container.encode(comments, forKey: .comments)
        try container.encode(likes, forKey: .likes)
        try container.encode(media, forKey: .media)
        try container.encode(users, forKey: .user)
    }
    
}
