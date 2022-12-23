//
//  ModelPhotos.swift
//  VK_Client
//
//  Created by  Daria on 13.12.2022.
//

import Foundation
import RealmSwift


struct PhotoResponse: Decodable {
    var response: Photos
}

struct Photos: Decodable {
    var count: Int
    var items: [Photo]
}

struct Photo: Decodable {
    var ownerId: Int
    var sizes: [Sizes]
    
    enum CodingKeys: String, CodingKey {
    case ownerId = "owner_id"
    case sizes
    }
    }

struct Sizes: Decodable {
    var url: String
}




