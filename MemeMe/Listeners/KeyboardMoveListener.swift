//
//  KeyboardMoveListener.swift
//  MemeMe
//
//  Created by Hiren Samtani on 12/05/18.
//  Copyright © 2018 Hiren Samtani. All rights reserved.
//

import Foundation
import UIKit

class KeyboardMoveListener : NSObject {
    var view: UIView?
    var elements: [UIResponder] = []
    let notificationCenter = NotificationCenter.default
    
    func subscribe(view: UIView, elements: [UIResponder]) {
        self.view = view
        self.elements = elements
        
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    func unsubscribe() {
        notificationCenter.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        notificationCenter.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
        for element in elements {
            if element.isFirstResponder {
                view!.frame.origin.y = -getKeyboardHeight(notification)
                return
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view!.frame.origin.y = 0
    }
    
    
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}
