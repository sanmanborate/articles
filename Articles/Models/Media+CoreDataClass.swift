//
//  Media+CoreDataClass.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Media)
public class Media: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt
        case blogId
        case url
        case image
        case title
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Media", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.blogId = try container.decodeIfPresent(String.self, forKey: .blogId)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
        self.image = try container.decodeIfPresent(URL.self, forKey: .image)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(blogId, forKey: .blogId)
        try container.encode(url, forKey: .url)
        try container.encode(image, forKey: .image)
        try container.encode(title, forKey: .title)
    }
}
