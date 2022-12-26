//
//  NewsCell.swift
//  VK_Client
//
//  Created by  Daria on 12.11.2022.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsAvatar: AvatarView!
    @IBOutlet weak var newsAvtor: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
