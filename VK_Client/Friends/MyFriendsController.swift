//
//  MyFriendsController.swift
//  VK_Client
//
//  Created by  Daria on 18.10.2022.
//

import UIKit
import RealmSwift


class MyFriendsController: UITableViewController {
    
    let getDataFromVk = GetDataFromVK()
    var friends = [Friends]()
    var friendsListModifed: [String] = []
    var namesListFixed: [String] = []
    var lettersOfNames: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFriendsFromRealm()
    
        GetDataFromVK().getFriends() { [weak self] () in
            self?.loadFriendsFromRealm()
        }
        
    }
        
    // MARK: - functions
    
    func loadFriendsFromRealm() {
        do {
            let realm = try Realm()
            let friendsFromRealm = realm.objects(Friends.self)
            friends = Array(friendsFromRealm)
            guard friends.count != 0 else { return }
            makeNamesList()
            sortCharacterOfNamesAlphabet()
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    func makeNamesList() {
        namesListFixed.removeAll()
        for item in 0...(friends.count - 1){
            namesListFixed.append(friends[item].name)
        }
        friendsListModifed = namesListFixed
    }
        
    func sortCharacterOfNamesAlphabet() {
        var lettersSet = Set<Character>()
        lettersOfNames = []
        for name in friendsListModifed {
            lettersSet.insert(name[name.startIndex])
        }

        for letter in lettersSet.sorted() {
            lettersOfNames.append(String(letter))
        }
    }
    
    func getNameFriendForCell(_ indexPath: IndexPath) -> String {
        var namesRows = [String]()
        for name in friendsListModifed.sorted() {
            if lettersOfNames[indexPath.section].contains(name.first!) {
                namesRows.append(name)
            }
        }
        return namesRows[indexPath.row]
    }
    
    func getAvatarFriendForCell(_ indexPath: IndexPath) -> URL? {
        for friend in friends {
            let namesRows = getNameFriendForCell(indexPath)
            if  friend.name.contains(namesRows) {
                return URL(string: friend.avatar)
            }
        }
        return nil
    }
    
    func getIDFriend(_ indexPath: IndexPath) -> String {
        var ownerIDs = ""
        for friend in friends {
            let namesRows = getNameFriendForCell(indexPath)
            if friend.name.contains(namesRows) {
                ownerIDs = friend.id
       
            }
        }
        return ownerIDs
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return lettersOfNames.count
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return lettersOfNames
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
        let letter: UILabel = UILabel(frame: CGRect(x: 30, y: 5, width: 20, height: 20))
        letter.textColor = UIColor.black.withAlphaComponent(0.5)
        letter.text = lettersOfNames[section]
        letter.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.light)
        header.addSubview(letter)
        
        return header
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countOfRows = 0
        for user in friendsListModifed {
            if lettersOfNames[section].contains(user.first!) {
               countOfRows += 1
            }
        }
        return countOfRows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsCell
        
        cell.labelFriendsCell.text = getNameFriendForCell(indexPath)
        if let imgUrl = getAvatarFriendForCell(indexPath) {
        cell.imageFriendsCell.avatarImage.load(url: imgUrl)
        }
        
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto"{
            guard let friend = segue.destination as? PhotoController else { return }
            if let indexPath = tableView.indexPathForSelectedRow {
                friend.title = getNameFriendForCell(indexPath)
                friend.ownerID = getIDFriend(indexPath)
            }
        }
    }
    

}

