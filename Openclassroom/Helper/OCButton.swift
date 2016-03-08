//
//  OCButton.swift
//  Openclassroom
//
//  Created by Paul on 05/03/2016.
//  Copyright © 2016 paulboiseau. All rights reserved.
//

import UIKit

extension UIButton {
    func OCdefaultButton(color: UIColor) {
        self.backgroundColor = color
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = color.CGColor
    }
    
    func OCborderButton(color: UIColor) {
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 2
        self.layer.borderColor = color.CGColor
    }
}
