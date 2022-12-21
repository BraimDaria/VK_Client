//
//  GetDataFromVK.swift
//  VK_Client
//
//  Created by  Daria on 02.12.2022.
//

import Foundation
import Alamofire
import RealmSwift

class GetDataFromVK {
    
    
    func getFriends (token: String, completion: @escaping ([Friends]) -> ()) {
        
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: String(Session.shared.userId)),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let arrayFriends = try JSONDecoder().decode(FriendsResponse.self, from: data)
                var fullNamesFriends: [Friends] = []
                for i in 0...arrayFriends.response.items.count-1 {
                    let name = ((arrayFriends.response.items[i].firstName) + " " + (arrayFriends.response.items[i].lastName))
                    let avatar = arrayFriends.response.items[i].photo
                    let id = String(arrayFriends.response.items[i].id)
                    fullNamesFriends.append(Friends.init(name: name, avatar: avatar, id: id))
                }
                completion(fullNamesFriends)
            } catch let error {
                print(error)
                completion([])
            }
        }
        task.resume()
        
            func saveFriendsToRealm(_ fullNamesFriends: [Friends]) {
                do {
                    let realm = try Realm()
                    realm.beginWrite()
                    realm.add(fullNamesFriends)
                    try realm.commitWrite()
                } catch {
                    print(error)
                }
            }
    }
    
    func getGroups(token: String, completion: @escaping ([Group]) -> ()) {
        
        let baseUrl = "https://api.vk.com/method"
        let url = baseUrl + "/groups.get"
        
        let param: Parameters = [
            "access_token": Session.shared.token,
            "extended": 1,
            "fields": "name, photo_100",
            "v": "5.131"
        ]
        
        AF.request(url, method: .post, parameters: param).response { res in
            if let data = res.data{
                if let groups = try? JSONDecoder().decode(GroupResponse.self,from: data).response.items {
                    completion(groups)
                }
            }
        }
        
        func saveGroupsToRealm(_ groups: [GroupsRealm]) {
            do {
                let realm = try Realm()
                realm.beginWrite()
                realm.add(groups)
                try realm.commitWrite()
            } catch {
                print(error)
            }
        }
        
    }
    
    func getPhotos (owner_id: String, complition: @escaping ([String]) -> Void ) {
        
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: owner_id),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
                
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let arrayPhotosFriend = try JSONDecoder().decode(PhotoResponse.self, from: data)
                var photosFriend: [String] = []
                
                for i in 0...arrayPhotosFriend.response.items.count-1 {
                    if let urlPhoto = arrayPhotosFriend.response.items[i].sizes.last?.url {
                        photosFriend.append(urlPhoto)
                    }
                }
                complition(photosFriend)
            } catch let error {
                print(error)
                complition([])
            }
        }
        task.resume()
    }
    
    func savePhotosToRealm(_ photosFriend: [PhotosRealm]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(photosFriend)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    
    
}


