//
//  PhotoController.swift
//  VK_Client
//
//  Created by  Daria on 18.10.2022.
//

import UIKit

class PhotoController: UICollectionViewController {
    
    let session = Session.shared
    let getDataFromVk = GetDataFromVK()
    var photos = [Photo]()
    var collectionPhotos: [String] = []
    var userID = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetDataFromVK().getPhotos(owner_id: userID) { [weak self] (complition) in 
            DispatchQueue.main.async {
                self?.collectionPhotos = complition
                self?.collectionView.reloadData()
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionPhotos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        if let imgUrl = URL(string: collectionPhotos[indexPath.row]) {
            cell.friendPhotos.load(url: imgUrl)
        }
        
        return cell
    }
    
}
    

