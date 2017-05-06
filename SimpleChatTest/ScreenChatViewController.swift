//
//  ScreenChatViewController.swift
//  SimpleChatTest
//
//  Created by Nguyen Duc Hien on 2017/04/23.
//  Copyright © 2017年 Nguyen Duc Hien. All rights reserved.
//

import UIKit
import Firebase
class ScreenChatViewController: UIViewController {
    
    @IBOutlet weak var txtMessage: UITextField!
    @IBOutlet weak var tblChat: UITableView!
    
    var tableName:FIRDatabaseReference!
    
    @IBAction func btnASend(_ sender: Any) {
        
        let mess:Dictionary<String,String> = ["id":currentUser.id, "message":txtMessage.text!]
        tableName.childByAutoId().setValue(mess)
        txtMessage.text = ""
        if(txtChat.count == 0)
        {
         addListChat(user1: currentUser, user2: visitor)
         addListChat(user1: visitor, user2: currentUser)
        
        }
    }
    
    @IBOutlet weak var constraintViewText: NSLayoutConstraint!
    
    var arridChat:Array<String> = Array<String>()
    var txtChat:Array<String> = Array<String>()
    var userChat:Array<User> = Array<User>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showHideKeyboard()
        tblChat.dataSource = self
        tblChat.delegate = self
        arridChat.append(currentUser.id)
        arridChat.append(visitor.id)
        let key:String = "\(arridChat[0])\(arridChat[1])"
        
        tableName = ref.child("Chat").child(key)
        
        tableName.observe(.childAdded, with: { (snapshot) in
            let postDict = snapshot.value as? [String:Any]
            if (postDict != nil)
            {
                if(postDict?["id"] as! String == currentUser.id)
                {
                    self.userChat.append(currentUser)
                }
                else
                {
                    self.userChat.append(visitor)
                }
                
                self.txtChat.append(postDict?["message"] as! String)
                self.tblChat.reloadData()
                
                
            }
        })
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func showHideKeyboard()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(ScreenChatViewController.showKey(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ScreenChatViewController.hideKey(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    func showKey(_ notification: Notification)
    {
        let s:NSValue = (notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let rect:CGRect = s.cgRectValue
        self.constraintViewText.constant = rect.size.height
        UIView.animate(withDuration: 1) { () -> Void in
            self.view.layoutIfNeeded()
            
            
        }
    }
    
    
    func hideKey(_ notification: Notification)
    {
        self.constraintViewText.constant = 0
        UIView.animate(withDuration: 1) { () -> Void in
            self.view.layoutIfNeeded()
        }
    }
    
    func addListChat(user1:User,user2:User)
    {
        let tableName2 = ref.child("ListChat").child(user1.id).child(user2.id)
        let user:Dictionary<String,String> = ["id":user2.id, "email":user2.email, "fullName":user2.fullName, "linkAvatar": user2.linkAvatar]
        tableName2.setValue(user)
        

    }
    
}

extension ScreenChatViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return txtChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(currentUser.id == userChat[indexPath.row].id)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! ScreenChat2TableViewCell
            cell.lblMess.text = txtChat[indexPath.row]
            cell.imgAvatar.image = currentUser.Avatar
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! ScreenChat1TableViewCell
            cell.lblMess.text = txtChat[indexPath.row]
            cell.imgAvatar.image = visitor.Avatar
            return cell
        }
    }
}
