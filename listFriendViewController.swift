//
//  listFriendViewController.swift
//  SimpleChatTest
//
//  Created by Nguyen Duc Hien on 10/25/16.
//  Copyright © 2016 Nguyen Duc Hien. All rights reserved.
//

import UIKit
import Firebase

var visitor: User!

class listFriendViewController: UIViewController {

    let currentUser = FIRAuth.auth()!.currentUser!
    //Tạo ra 1 dãy chứa Data User
    var listFriend:Array<User> = Array<User>()

    @IBOutlet weak var tbtlistFriend: UITableView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tbtlistFriend.dataSource = self
        tbtlistFriend.delegate = self
        //Lấy thông tin Data từ Firebase Database về.
        let tableName = ref.child("List Friend")
        tableName.observe(.childAdded, with: {(snapshot) in
            let postDict = snapshot.value as? [String : AnyObject]
            if (postDict != nil) {
                let email:String = (postDict?["email"])! as! String
                
                let fullName:String = (postDict?["fullName"])! as! String
                
                let linkAvatar:String = (postDict?["linkAvatar"])! as! String
                
                let user:User = User(id: snapshot.key, email: email, fullName: fullName, linkAvatar: linkAvatar)
                if(user.id != self.currentUser.uid)
                {
                self.listFriend.append(user)
                }
                self.tbtlistFriend.reloadData()
                
            }
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//Dùng hàm Extension này để sử dụng lại được Cell
extension listFriendViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listFriend.count
    }
    //Hiển thị ảnh và tên vào trong Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for:indexPath) as! listFriendTableViewCell
        cell.lblName.text = listFriend[indexPath.row].fullName
        cell.imgAvatar.loadAvatar(link: listFriend[indexPath.row].linkAvatar)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        visitor = listFriend[indexPath.row]
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
        
   
