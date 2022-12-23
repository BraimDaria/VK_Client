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
    
    init(photo: String) {
        self.photo = photo
    }
    
    required override init() {
        super.init()
    }
}
