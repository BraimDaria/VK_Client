//
//  NewsController.swift
//  VK_Client
//
//  Created by  Daria on 12.11.2022.
//

import UIKit

class NewsController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    struct PostNews {
        var avatar: UIImage
        var newsAvtor: String
        var newsText: String
        var newsImage: UIImage
    }
    
    
    var newsList: [PostNews] = [PostNews(avatar: UIImage(named: "photo1668259483")!, newsAvtor: "Наука|ФАКТЫ", newsText: "Ого! Посмотрите какую фотку Сатурна сделал наш подписчик. Фотография сделана за 30 минут до заката. Параметры съемки обещал прислать. Напишем в комментариях чуть позже.", newsImage: UIImage(named: "photo1668208196")!)
    ]
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        
        cell.newsAvatar.avatarImage.image = newsList[indexPath.row].avatar
        cell.newsAvtor.text = newsList[indexPath.row].newsAvtor
        
        cell.newsText.text = newsList[indexPath.row].newsText
        cell.newsText.numberOfLines = 5
        
        cell.newsImage.image = newsList[indexPath.row].newsImage
        cell.newsImage.contentMode = .scaleAspectFill
        
        
        return cell
        
    }
}
