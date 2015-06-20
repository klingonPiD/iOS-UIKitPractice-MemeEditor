//
//  MemeTextFieldDelegate.swift
//  MeMePicker
//
//  Created by Theo on 5/27/15.
//  Copyright (c) 2015 pid. All rights reserved.
//

import Foundation
import UIKit

class MemeTextFieldDelgate : NSObject, UITextFieldDelegate{
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
