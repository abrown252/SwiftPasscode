//
//  PasscodeViewController+UIKeyCommand.swift
//  SwiftPasscode
//
//  Created by Alex Brown on 22/04/2020.
//

import Foundation
import UIKit

extension PasscodeViewController {
    
    public override var canBecomeFirstResponder: Bool {
        return true
    }
    
    public override var keyCommands: [UIKeyCommand]? {
        var commands = [UIKeyCommand]()
        
        for i in 0...9 {
            commands.append(UIKeyCommand(input: "\(i)", modifierFlags: [], action: #selector(valueSelected(command:)), discoverabilityTitle: "\(i)"))
        }
        
        return commands
    }
    
    @objc func valueSelected(command: UIKeyCommand) {
        guard
            let input = command.input,
            let value = Int(input)
            else {return}
        
        valueEntered(value: value)
    }
}
