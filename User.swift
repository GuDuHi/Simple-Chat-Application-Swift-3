//
//  File.swift
//  SimpleChatTest
//
//  Created by Nguyen Duc Hien on 10/21/16.
//  Copyright © 2016 Nguyen Duc Hien. All rights reserved.
//

import Foundation
import UIKit
struct User {
    let id:String!
    let email:String!
    let fullName:String!
    let linkAvatar:String!
    var Avatar: UIImage!
    
    init() {
        id = ""
        email = ""
        fullName = ""
        linkAvatar = ""
        Avatar = UIImage(named:"JustGrimes-Cargo")
    }
    init(id:String, email:String, fullName:String, linkAvatar:String) {
        self.id = id
        self.email = email
        self.fullName = fullName
        self.linkAvatar = linkAvatar
        self.Avatar = UIImage(named:"JustGrimes-Cargo")
    }
    
}
