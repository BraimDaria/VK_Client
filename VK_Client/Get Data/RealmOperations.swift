//
//  RealmOperations.swift
//  VK_Client
//
//  Created by  Daria on 22.12.2022.
//

import Foundation
import RealmSwift

class RealmOperations {
    
    func saveFriendsToRealm(_ friendList: [Friends]) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldFriendList = realm.objects(Friends.self)
                realm.delete(oldFriendList)
                realm.add(friendList) 
            }
        } catch {
            print(error)
        }
    }
    
    func saveGroupsToRealm(_ grougList: [GroupsRealm]) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldGroupList = realm.objects(GroupsRealm.self)
                realm.delete(oldGroupList)
                realm.add(grougList)
            }
        } catch {
            print(error)
        }
    }
    
    func savePhotosToRealm(_ photoList: [PhotosRealm], _ ownerID: String) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldPhotoList = realm.objects(PhotosRealm.self).filter("ownerID == %@", ownerID)
                realm.delete(oldPhotoList)
                realm.add(photoList)
            }
        } catch {
            print(error)
        }
    }
    
}
