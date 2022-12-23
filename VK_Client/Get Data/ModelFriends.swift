//
//  Friends.swift
//  VK_Client
//
//  Created by  Daria on 12.12.2022.
//

import UIKit
import RealmSwift


class Friends: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var avatar: String  = ""
    @objc dynamic var id: String  = ""
   
    
    init(name: String, avatar: String, id: String) {
        self.name = name
        self.avatar = avatar
        self.id = id
    }

    required override init() {
        super.init()
    }
}



