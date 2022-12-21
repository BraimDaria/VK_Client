//
//  Model.swift
//  VK_Client
//
//  Created by  Daria on 09.12.2022.
//

import Foundation
import RealmSwift

struct FriendsResponse: Decodable {
    var response: Response
}
    struct Response: Decodable {
        var count: Int
        var items: [Items]
    }
struct Items: Decodable {
    var id: Int
    var firstName: String
    var lastName: String
    var photo: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_50"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        photo = try container.decode(String.self, forKey: .photo)
       
    }
}
            
          


