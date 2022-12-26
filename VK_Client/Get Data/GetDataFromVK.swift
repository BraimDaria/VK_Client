//
//  GetDataFromVK.swift
//  VK_Client
//
//  Created by  Daria on 02.12.2022.
//

import Foundation
import RealmSwift

class GetDataFromVK {
    
    
    func getFriends(complition: @escaping () -> Void ) {
        
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
                
                DispatchQueue.main.async {
                    RealmOperations().saveFriendsToRealm(fullNamesFriends)
                    complition()
                }
            } catch let error {
                print(error)
                complition()
            }
        }
        task.resume()
    }
    
    func getGroups(complition: @escaping () -> Void ) {
            
            let configuration = URLSessionConfiguration.default
            let session =  URLSession(configuration: configuration)
            
            var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/groups.get"
            urlConstructor.queryItems = [
                URLQueryItem(name: "user_id", value: String(Session.shared.userId)),
                URLQueryItem(name: "extended", value: "1"),
                URLQueryItem(name: "access_token", value: Session.shared.token),
                URLQueryItem(name: "v", value: "5.131")
            ]
            
            let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
                
                guard let data = data else { return }
                
                do {
                    let arrayGroups = try JSONDecoder().decode(GroupResponse.self, from: data)
                    var groupList: [GroupsRealm] = []
                    for i in 0...arrayGroups.response.items.count-1 {
                        let name = ((arrayGroups.response.items[i].name))
                        let photo = arrayGroups.response.items[i].photo
                        groupList.append(GroupsRealm.init(name: name, photo: photo))
                    }
                    
                    DispatchQueue.main.async {
                        RealmOperations().saveGroupsToRealm(groupList)
                        complition()
                    }
                    
                } catch let error {
                    print(error)
                    complition()
                }
            }
            task.resume()
            
        }
    
        func getPhotos(_ ownerID: String, complition: @escaping () -> Void )  {
        
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/photos.getAll"
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: ownerID),
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        let task = session.dataTask(with: urlConstructor.url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let arrayPhotosFriend = try JSONDecoder().decode(PhotosResponse.self, from: data)
                var photosFriend: [PhotosRealm] = []
                var ownerID = ""

                for i in 0...arrayPhotosFriend.response.items.count-1 {
                    if let urlPhoto = arrayPhotosFriend.response.items[i].sizes.last?.url {
                        ownerID = String(arrayPhotosFriend.response.items[i].ownerID)
                        photosFriend.append(PhotosRealm.init(photo: urlPhoto, ownerID: ownerID))
                    }
                }
                DispatchQueue.main.async {
                    RealmOperations().savePhotosToRealm(photosFriend, ownerID)
                    complition()
                }
            } catch let error {
                print(error)
                complition()
            }
        }
        task.resume()
    }
    
    }

    



