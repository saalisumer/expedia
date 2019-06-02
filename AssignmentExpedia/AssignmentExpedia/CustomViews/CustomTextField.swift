//
//  CustomTextField.swift
//  AssignmentExpedia
//
//  Created by Saalis Umer on 6/1/19.
//  Copyright © 2019 Saalis Umer. All rights reserved.
//

import UIKit

class CustomTextField: UITextField {
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        super.leftViewRect(forBounds: bounds)
        return CGRect(x: 9, y: 9, width: bounds.size.height-18, height: bounds.size.height-18)
    }
}
