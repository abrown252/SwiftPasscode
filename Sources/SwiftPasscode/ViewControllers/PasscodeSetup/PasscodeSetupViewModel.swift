//
//  PasscodeSetupViewModel.swift
//  Passcode
//
//  Created by Alex Brown on 15/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

import Foundation

internal struct PasscodeSetupViewModel {
    
    let configuration: PasscodeSetupConfiguration
    
    var firstPasscode: [Int] = []
    var secondPasscode: [Int] = []
    
    var passcodesAreEqual: Bool {
        return firstPasscode == secondPasscode
    }
    
    var hasFirstPasscode: Bool {
        return firstPasscode.count == 4
    }
    
    var hasSecondPasscode: Bool {
        return secondPasscode.count == 4
    }
    
    mutating func reset() {
        firstPasscode.removeAll()
        secondPasscode.removeAll()
    }
}
