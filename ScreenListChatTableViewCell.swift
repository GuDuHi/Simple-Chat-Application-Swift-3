//
//  ScreenListChatTableViewCell.swift
//  SimpleChatTest
//
//  Created by Nguyen Duc Hien on 2017/05/04.
//  Copyright © 2017年 Nguyen Duc Hien. All rights reserved.
//

import UIKit

class ScreenListChatTableViewCell: UITableViewCell {
    @IBOutlet weak var imdAvatar: UIImageView!

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
