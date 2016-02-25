//
//  MyCookBookListItemCell.swift
//  MyAppTest
//
//  Created by yzy on 16/2/25.
//  Copyright © 2016年 yzy. All rights reserved.
//

import UIKit

class MyCookBookListItemCell: UITableViewCell {
    @IBOutlet weak var foodPictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setCookBook(cookBook:MyCookBook) {
        let urlString = "http://tnfs.tngou.net/img\((cookBook.imgUrl)!)"
//        self.foodPictureImageView.setImageWithURL(NSURL(string: urlString)!)
        self.foodPictureImageView.setImageWithURL(NSURL(string: urlString)!, placeholderImage: nil)
        self.nameLabel.text = cookBook.name
        self.descriptionLabel.text = cookBook.descriptions
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
