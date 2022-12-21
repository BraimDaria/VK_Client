//
//  GroupsController.swift
//  VK_Client
//
//  Created by  Daria on 18.10.2022.
//

import UIKit

class GroupsController: UITableViewController, UISearchBarDelegate {
    
    let session = Session.shared
    let getDataFromVk = GetDataFromVK()
    var groups = [Group]()
    var filteredGroups = [Group]()
    var isSearching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        self.tableView.dataSource = self
        getDataFromVk.getGroups(token: session.token) {
            groups in
            self.groups = groups
            
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredGroups.removeAll()
        guard searchText != "" || searchText != " " else {
            print("Empty Search")
            return
        }
        
        for group in groups {
            let text = searchText.lowercased()
            let isArrayContain = group.name.lowercased().range(of: text)
            
            if isArrayContain != nil {
                print("Search complete")
                filteredGroups.append(group)
            }
        }
        
        print(filteredGroups)
        
        
        if searchBar.text == "" {
            isSearching = false
            tableView.reloadData()
        } else {
            isSearching = true
            filteredGroups = groups.filter({$0.name.contains(searchBar.text ?? "")})
            tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredGroups.count
        } else {
            return groups.count
        }
        
    }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsCell
            
            if isSearching {
                cell.labelGroupsCell.text = filteredGroups[indexPath.row].name
                if let imgUrl = URL(string: filteredGroups[indexPath.row].photo) {
                    cell.imageGroupsCell.load(url: imgUrl)
                }
                
            } else {
                cell.labelGroupsCell.text = groups[indexPath.row].name
                if let imgUrl = URL(string: groups[indexPath.row].photo) {
                    cell.imageGroupsCell.load(url: imgUrl)
                }
                
            }
            
            return cell
        }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
    groups.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade) }
    }
        
    }


