//
//  NewGroupsController.swift
//  VK_Client
//
//  Created by  Daria on 19.10.2022.
//

import UIKit

class NewGroupsController: UITableViewController {
    
    //let session = Session.shared
    let getDataFromVk = GetDataFromVK()
    
}
//    var newGroups = [
//       Group(image: UIImage.init(named: "17"),name: "Эрмитаж"),
//       Group(image: UIImage.init(named: "18"),name: "Моя провинция"),
//       Group(image: UIImage.init(named: "19"),name: "Just Cook"),
//       Group(image: UIImage.init(named: "20"),name: "Мой странный кот"),
//       Group(image: UIImage.init(named: "21"),name: "Идеи вашего дома"),
//       Group(image: UIImage.init(named: "22"),name: "Зона комфорта"),
//       Group(image: UIImage.init(named: "23"),name: "Журнал Кинжал"),
//       Group(image: UIImage.init(named: "24"),name: "Мода")
//    ]
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //getDataFromVk.searchGroups(token: session.token)
//
//    }
//
//
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return newGroups.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewGroupsCell", for: indexPath) as? NewGroupsCell else {
//
//            preconditionFailure("Ошибка")
//
//        }
//
//        cell.labelNewGroupsCell.text = newGroups[indexPath.row].name
//        cell.imageNewGroupsCell.image = newGroups[indexPath.row].image
//
//
//        print(indexPath.section)
//        print(indexPath.row)
//
//        return cell
//
//    }
//}
