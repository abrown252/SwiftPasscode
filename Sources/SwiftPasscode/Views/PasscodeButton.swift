//
//  PasscodeButton.swift
//  Passcode
//
//  Created by Alex Brown on 14/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

import UIKit

internal class PasscodeButton: UIButton {

    let passcodeValue: Int

    var isDeleteButton: Bool {
        return passcodeValue == -2
    }
    
    init(passcodeValue: Int) {
        self.passcodeValue = passcodeValue
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font = UIFont.systemFont(ofSize: 34, weight: .medium)
        widthAnchor.constraint(equalToConstant: 76).isActive = true
        heightAnchor.constraint(equalToConstant: 76).isActive = true
        clipsToBounds = true
        setTitleColor(.lightGray, for: .disabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) not supported")
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isDeleteButton {return}
            
            UIView.animate(withDuration: 0.1) {
                if self.isHighlighted {
                    self.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4).cgColor
                } else {
                    self.layer.backgroundColor = UIColor.clear.cgColor
                }
            }
        }
    }

}
