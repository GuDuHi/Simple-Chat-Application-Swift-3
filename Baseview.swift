//
//  Baseview.swift
//  SimpleChatTest
//
//  Created by Nguyen Duc Hien on 10/26/16.
//  Copyright © 2016 Nguyen Duc Hien. All rights reserved.
//

import UIKit

extension UIImageView {
    func skin(){
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
   
    func loadAvatar(link:String){
        let queue: DispatchQueue = DispatchQueue(label: "LoadImages")
        let activity:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activity.frame = CGRect(x: self.frame.size.width/2, y: self.frame.size.height/2, width: 0, height: 0)
        activity.color = UIColor.blue
        self.addSubview(activity)
        activity.startAnimating()
        queue.async {
            let url:URL = URL(string: link)!
            do
            {
                let data:Data = try Data(contentsOf: url)
                DispatchQueue.main.async(execute: {
                    activity.stopAnimating()
                    self.image = UIImage(data: data)
                })
            }
            catch
            {
                print("Error")
            }
        }
    }
}
