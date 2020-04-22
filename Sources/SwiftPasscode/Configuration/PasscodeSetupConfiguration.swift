//
//  PasscodeSetupConfiguration.swift
//  Passcode
//
//  Created by Alex Brown on 15/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

import Foundation

public struct PasscodeSetupConfiguration: PasscodeConfiguration {
    public init(canCancel: Bool, passcodeEntered: @escaping (PasscodeViewController, Bool, Int) -> Void) {
        self.canCancel = canCancel
        self.passcodeEntered = passcodeEntered
    }

    var passcodeEntered: (PasscodeViewController, Bool, Int) -> Void
    var canCancel: Bool
    
    var type: PasscodeEntryType {
        return .setup
    }
}
