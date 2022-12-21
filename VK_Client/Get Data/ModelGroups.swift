//
//  ModelGroups.swift
//  VK_Client
//
//  Created by  Daria on 21.12.2022.
//

import UIKit
import RealmSwift

class GroupsRealm: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var photo: String  = ""
    
    
    init(name: String, photo: String) {
        self.name = name
        self.photo = photo
    }

    required override init() {
        super.init()
    }
}
