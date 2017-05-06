//
//  RegisterViewController.swift
//  SimpleChatTest
//
//  Created by Nguyen Duc Hien on 10/19/16.
//  Copyright © 2016 Nguyen Duc Hien. All rights reserved.
//

import UIKit
import Firebase
//Sử dụng Firebase Strorage
let storage = FIRStorage.storage()
let storageRef = storage.reference(forURL: "gs://simplechattest-442fd.appspot.com") //Link Storage của App

class RegisterViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    var imgData:Data!
    
    @IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func btnRegCancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    /*@IBOutlet weak var avaImg: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!*/
    @IBAction func regButton(_ sender: AnyObject) {
        
        let email:String = emailTextField.text!
        let pwd: String = passwordTextField.text!
        //Tạo User mới đồng thời cho Login luôn và yêu cầu thay đổi thông tin người dùng ngay lập tức
        FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: {(user, error) in
            if
                let user = user{
                print(user.displayName as Any)
                print(user.email as Any)
                FIRAuth.auth()?.signIn(withEmail: email, password: pwd) { (user, error) in
                    if(error == nil)
                    {
                        
                        self.noticeSuccess("Login Success!")
                       
                    }
                    else {
                        self.errorNotice("Error!", autoClear: true)
                    }
                    self.clearAllNotice()
                }
                //Đường dẫn lưu ảnh trên Storage
                let avataRef = storageRef.child("images/\(email).jpg")
                //Upload ảnh lên trên Firebase Storage
                let uploadTask = avataRef.put(self.imgData, metadata: nil) { metadata, error in
                    if (error != nil) {
                        self.noticeError("Upload Picture Error")
                    } else {
                        // Metadata contains file metadata such as size, content-type, and download URL.
                        let downloadURL = metadata!.downloadURL()
                        
                        let user = FIRAuth.auth()?.currentUser
                        if let user = user {
                            let changeRequest = user.profileChangeRequest()
                            
                            changeRequest.displayName = self.nameTextField.text!
                            changeRequest.photoURL = downloadURL
                            changeRequest.commitChanges(completion: {(error) in
                                if(error == nil)
                                {
                                self.successNotice("Register Success!", autoClear: true)
                                self.gotoScreen()
                                }
                                else
                                {
                                    self.errorNotice("Error!", autoClear: true)
                                }
                    })
                        
                            self.clearAllNotice()
                            
                        }
                        
                    }
                    
                }
                uploadTask.resume()
                            }else{
                self.errorNotice("Error!", autoClear: true)
            }
        })
       
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let avaTap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.loadImg(_:)))
        avaTap .numberOfTapsRequired = 1
        avaImg.isUserInteractionEnabled = true
        avaImg.addGestureRecognizer(avaTap)
        
        //round ava
        avaImg.layer.cornerRadius = avaImg.frame.size.width / 2
        avaImg.clipsToBounds = true
        // Do any additional setup after loading the view.ß
        
        self.hideKeyboardWhenTappedAround()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
    //Call picker for img select
    // Hàm để chọn được hình ảnh làm avata trong PhotoLibarary của User
    func loadImg(_ recognizer:UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true 
        present(picker, animated: true, completion: nil)
        
    }
    //Hàm này để hoàn thành việc chọn ảnh
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        avaImg.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
        //Giảm bớt dung lượng ảnh Upload lên Sever để cho Sever đỡ bị quá tải.
        let tapImg = info[UIImagePickerControllerOriginalImage] as! UIImage
        let imgValue = max(tapImg.size.width, tapImg.size.height)
        if (imgValue > 3000) {
            imgData = UIImageJPEGRepresentation(tapImg, 0.1)
        }
        else if (imgValue > 2000)
        {
            imgData = UIImageJPEGRepresentation(tapImg, 0.3)
        }
        else
        {
            imgData = UIImagePNGRepresentation(tapImg)
        }
        avaImg.image = UIImage(data: imgData)
        
    }
       }



