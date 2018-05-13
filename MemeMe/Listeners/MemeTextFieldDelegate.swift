//
//  MemeTextFieldDelegate.swift
//  MemeMe
//
//  Created by Hiren Samtani on 12/05/18.
//  Copyright © 2018 Hiren Samtani. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelegate: NSObject, UITextFieldDelegate {
    
    var isDefaultText: Bool = true
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.backgroundColor = UIColor.white
        
        if isDefaultText {
            textField.text = ""
            isDefaultText = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = UIColor.clear
    }
    
}
