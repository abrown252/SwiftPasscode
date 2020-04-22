//
//  UILabel+Animation.swift
//  Passcode
//
//  Created by Alex Brown on 15/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

import Foundation
import UIKit

internal extension UILabel {
    
    func animateTextChange(new: String) {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        }) { (_) in
            self.text = new
            UIView.animate(withDuration: 0.2) {
                self.alpha = 1
            }
        }
    }

}
