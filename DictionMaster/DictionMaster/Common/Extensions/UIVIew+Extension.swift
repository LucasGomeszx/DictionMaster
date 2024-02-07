//
//  UIVIew+Extension.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 05/02/24.
//

import UIKit

extension UIView {
    
    func setButtonStyle() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 14
        self.backgroundColor = UIColor.primaryBlue
        self.isUserInteractionEnabled = true
    }
    
}
