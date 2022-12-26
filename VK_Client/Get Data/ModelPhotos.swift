//
//  ModelPhotos.swift
//  VK_Client
//
//  Created by  Daria on 21.12.2022.
//

import UIKit
import RealmSwift

class PhotosRealm: Object {
    @objc dynamic var photo: String = ""
    @objc dynamic var ownerID: String  = ""
    
    init(photo: String, ownerID: String) {
        self.photo = photo
        self.ownerID = ownerID
    }

    required override init() {
        super.init()
    }
}
