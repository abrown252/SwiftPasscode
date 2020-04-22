//
//  PasscodeViewModel.swift
//  Passcode
//
//  Created by Alex Brown on 15/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

import Foundation

internal struct PasscodeViewModel {
    
    let configuration: PasscodeConfiguration
    private(set) var passcodeValues: [Int] = []
    var passcodeButtons: [PasscodeButton] = []
    
    // condense passcode values into a single number
    var passcodeNumber: Int {
        var passcodeNum = 0
        for (index, value) in passcodeValues.enumerated() {
            switch index {
            case 0:
                passcodeNum += (value * 1000)
            case 1:
                passcodeNum += (value * 100)
            case 2:
                passcodeNum += (value * 10)
            case 3:
                passcodeNum += value
            default:
                passcodeNum += value
            }
        }
        return passcodeNum
    }
    
    var title: String {
        if entryType == .entry {
             return "Enter Passcode"
        }
        
        return "Change Passcode"
    }
    
    var entryType: PasscodeEntryType {
        return configuration.type
    }
    
    var passcodeEnteredCallback: (PasscodeViewController, Bool, Int) -> Void {
        return configuration.passcodeEntered
    }
        
    var canCancel: Bool {
        return configuration.canCancel
    }
    
    var deleteButtonTitle: String {
        if canCancel && passcodeValues.isEmpty {
            return "Cancel"
        }
        return "Delete"
    }
        
    init(configuration: PasscodeConfiguration) {
        self.configuration = configuration
    }
    
    func setButtonsEnabled(_ enabled: Bool) {
        passcodeButtons.forEach({ $0.isEnabled = enabled })
    }
        
    mutating func updatePasscode(with value: Int) {
        passcodeValues.append(value)
    }
    
    mutating func clearPasscode() {
        passcodeValues.removeAll()
    }
    
    mutating func deleteLast() {
        passcodeValues.removeLast()
    }
}
