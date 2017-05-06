//
//  AutoHideKeyboard.swift
//  SimpleChatTest
//
//  Created by Nguyen Duc Hien on 12/6/16.
//  Copyright © 2016 Nguyen Duc Hien. All rights reserved.
//

import Foundation
import UIKit
//Hide Keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard as (UIViewController) -> () -> ()))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
