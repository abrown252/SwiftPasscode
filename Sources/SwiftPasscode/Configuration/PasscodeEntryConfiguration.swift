//
//  PasscodeEntryConfiguration.swift
//  Passcode
//
//  Created by Alex Brown on 15/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

import Foundation

public struct PasscodeEntryConfiguration: PasscodeConfiguration {
    init(canCancel: Bool, numAttempts: Int?, correctPasscode: Int, passcodeEntered: @escaping (PasscodeViewController, Bool, Int) -> Void) {
        self.canCancel = canCancel
        self.numAttemps = numAttempts
        self.passcodeEntered = passcodeEntered
        self.correctPasscode = correctPasscode
    }
    
    public var passcodeEntered: (PasscodeViewController, Bool, Int) -> Void
    public var canCancel: Bool
    
    let numAttemps: Int?
    let correctPasscode: Int

    public var type: PasscodeEntryType {
        return .entry
    }
    
    var hasMaxAttempts: Bool {
        return numAttemps != nil
    }
}