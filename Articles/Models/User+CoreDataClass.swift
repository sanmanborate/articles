//
//  User+CoreDataClass.swift
//  Articles
//
//  Created by Apple on 14/06/20.
//  Copyright © 2020 Apple. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case createdAt
        case blogId
        case about
        case city
        case designation
        case lastname
        case name
        case avatar
    }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
                fatalError("Failed to decode User")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.createdAt = try container.decodeIfPresent(Date.self, forKey: .createdAt)
        self.blogId = try container.decodeIfPresent(String.self, forKey: .blogId)
        self.about = try container.decodeIfPresent(String.self, forKey: .about)
        self.city = try container.decodeIfPresent(String.self, forKey: .city)
        self.designation = try container.decodeIfPresent(String.self, forKey: .designation)
        self.lastname = try container.decodeIfPresent(String.self, forKey: .lastname)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.avatar = try container.decodeIfPresent(URL.self, forKey: .avatar)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(blogId, forKey: .blogId)
        try container.encode(about, forKey: .about)
        try container.encode(city, forKey: .city)
        try container.encode(designation, forKey: .designation)
        try container.encode(lastname, forKey: .lastname)
        try container.encode(name, forKey: .name)
        try container.encode(avatar, forKey: .avatar)
    }
}
