//
//  PasscodeValueView.swift
//  Passcode
//
//  Created by Alex Brown on 14/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

import UIKit

internal class PasscodeValueView: UIView {

    var passcodeValue: Int? {
        didSet {
            UIView.animate(withDuration: 0.2) {
                if self.passcodeValue == nil {
                    self.layer.backgroundColor = UIColor.clear.cgColor
                } else {
                    self.layer.backgroundColor = UIColor.white.cgColor
                }
            }
        }
    }

    var hasValue: Bool {
        return passcodeValue != nil
    }
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: 14).isActive = true
        heightAnchor.constraint(equalToConstant: 14).isActive = true
        layer.cornerRadius = 7
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) not supported")
    }
}
