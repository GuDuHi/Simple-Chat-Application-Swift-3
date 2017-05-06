//
//  ScreenChat2TableViewCell.swift
//  SimpleChatTest
//
//  Created by Nguyen Duc Hien on 2017/04/25.
//  Copyright © 2017年 Nguyen Duc Hien. All rights reserved.
//

import UIKit

class ScreenChat2TableViewCell: UITableViewCell {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblMess: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
