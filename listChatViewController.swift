//
//  listChatViewController.swift
//  SimpleChatTest
//
//  Created by Nguyen Duc Hien on 10/21/16.
//  Copyright © 2016 Nguyen Duc Hien. All rights reserved.
//

import UIKit
import Firebase
var  ref: FIRDatabaseReference!
var currentUser: User!
class listChatViewController: UIViewController {
    @IBOutlet weak var tblListChat: UITableView!
    //Tạo ra 1 dãy chứa Data User
    var listFriend:Array<User> = Array<User>()
    var arrUserChat:Array<User> = Array<User>()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblListChat.dataSource = self
        tblListChat.delegate = self
        ref = FIRDatabase.database().reference()
        
        // Do any additional setup after loading the view.
        
        if let user = FIRAuth.auth()?.currentUser {
            let name = user.displayName
            let email = user.email
            let photoUrl = user.photoURL
            let uid = user.uid;
            
            currentUser = User(id: uid, email: email!, fullName: name!, linkAvatar: String(describing: photoUrl!))
            
            let tableName = ref.child("List Friend")
            let userid = tableName.child(currentUser.id)
            let user:Dictionary<String,String> = ["email":currentUser.email,"fullName": currentUser.fullName, "linkAvatar":currentUser.linkAvatar]
            userid.setValue(user)
            
            
            let url:URL = URL(string: currentUser.linkAvatar)!
            do {
                
            let data:Data = try Data(contentsOf: url)
            currentUser.Avatar = UIImage(data: data)
            }
            catch
            {
                
            }
            
            
            //Lấy thông tin Data từ Firebase Database về.
            tableName.observe(.childAdded, with: {(snapshot) in
                let postDict = snapshot.value as? [String : AnyObject]
                if (postDict != nil) {
                    let email:String = (postDict?["email"])! as! String
                    
                    let fullName:String = (postDict?["fullName"])! as! String
                    
                    let linkAvatar:String = (postDict?["linkAvatar"])! as! String
                    
                    let user:User = User(id: snapshot.key, email: email, fullName: fullName, linkAvatar: linkAvatar)
                    
                    self.listFriend.append(user)
            
                }
            })
        } else {
            print("User not available")
        }
        
        let tableName = ref.child("ListChat").child(currentUser.id)
        
        tableName.observe(.childAdded, with: { (snapshot) in
         
            let postDict = snapshot.value as? [String : Any]
            if(postDict != nil)
            {
                let email:String = (postDict!["email"])! as! String
                let fullName:String = (postDict!["fullName"])! as! String
                let linkAvatar:String = (postDict!["linkAvatar"])! as! String
                let user:User = User(id: snapshot.key, email: email, fullName: fullName, linkAvatar: linkAvatar)
                self.arrUserChat.append(user)
                self.tblListChat.reloadData()
            }
            
        })
            
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
//Truyền dữ liệu vào trong cell
extension listChatViewController: UITableViewDataSource,UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrUserChat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for : indexPath) as! ScreenListChatTableViewCell
        cell.lblName.text = arrUserChat[indexPath.row].fullName
        cell.imdAvatar.loadAvatar(link: arrUserChat[indexPath.row].linkAvatar)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        visitor = arrUserChat[indexPath.row]
        
        let url:URL = URL(string: visitor.linkAvatar)!
        do{
            let data:Data = try Data(contentsOf: url)
            visitor.Avatar = UIImage(data: data)
        }
        catch{
            print("Loi load Avatar")
        }

    }
    
    
    
    
    
}
