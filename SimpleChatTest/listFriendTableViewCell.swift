//
//  listFriendTableViewCell.swift
//  SimpleChatTest
//
//  Created by Nguyen Duc Hien on 10/25/16.
//  Copyright © 2016 Nguyen Duc Hien. All rights reserved.
//

import UIKit

class listFriendTableViewCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
