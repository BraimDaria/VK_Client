//
//  ModelGroups.swift
//  VK_Client
//
//  Created by  Daria on 12.12.2022.
//

import Foundation
import RealmSwift


struct GroupResponse: Decodable {
    var response: Groups
}

struct Groups: Decodable {
    var count: Int
    var items: [Group]
}

struct Group: Decodable {
    var name: String
    var photo: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case photo = "photo_100"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        photo = try container.decode(String.self, forKey: .photo)
    }
    
}
