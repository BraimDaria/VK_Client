//
//  PhotoController.swift
//  VK_Client
//
//  Created by  Daria on 18.10.2022.
//

import UIKit
import RealmSwift


class PhotoController: UICollectionViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPhotosFromRealm()
        
        GetDataFromVK().getPhotos(ownerID) { [weak self] () in
            self?.loadPhotosFromRealm()
        }
    }
    
    var collectionPhotos: [PhotosRealm] = []
    var ownerID = ""
        
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        if let imgUrl = URL(string: collectionPhotos[indexPath.row].photo) {
            cell.friendPhotos.load(url: imgUrl)
        }
        
        return cell
    }
    
    func loadPhotosFromRealm() {
    do {
    let realm = try Realm()
    let photosFromRealm = realm.objects(PhotosRealm.self).filter("ownerID == %@", ownerID)
    collectionPhotos = Array(photosFromRealm)
    guard collectionPhotos.count != 0 else { return }
    collectionView.reloadData()
    } catch {
    print(error)
    }
        }
}
    

