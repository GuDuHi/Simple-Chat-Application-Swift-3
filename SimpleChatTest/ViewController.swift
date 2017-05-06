//
//  ViewController.swift
//  SimpleChatTest
//
//  Created by Nguyen Duc Hien on 10/19/16.
//  Copyright © 2016 Nguyen Duc Hien. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UIApplicationDelegate {

    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtpwd: UITextField!
    @IBAction func btnLogin(_ sender: AnyObject) {
        FIRAuth.auth()?.signIn(withEmail: txtemail.text!, password: txtpwd.text!) { (user, error) in
            
            
            if(error == nil)
            {
               self.successNotice("Login Success!", autoClear: true)
                self.gotoScreen()
            }
                
            else{
                self.noticeError("Error")
            }
            self.clearAllNotice()
        }
        
        
    }
    @IBAction func btnRegister(_ sender: AnyObject){
        if let registerVC = self.storyboard?.instantiateViewController(withIdentifier: SBIdentifier.RegisterVC.rawValue) {
            self.present(registerVC, animated: true, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! FIRAuth.auth()!.signOut()
        // Do any additional setup after loading the view, typically from a nib.
        isLoging()
        self.hideKeyboardWhenTappedAround()
    
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

func isLoging() {
    FIRAuth.auth()?.addStateDidChangeListener { auth, user in
        if user != nil {
    
            print("Login")
        } else {
            print("Not Login")
        }
    }
}
//Tạo Extension sử dụng trên toàn Project -> hàm Chuyển ViewController
extension UIViewController {
    func gotoScreen() {
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "isLogin")
        if (screen != nil) {
            self.present(screen!,animated: true, completion: nil)
        } else {
            print("Loi chuyen man hinh")
        }
    }
}
