//
//  PasscodeSetupConfiguration.swift
//  Passcode
//
//  Created by Alex Brown on 15/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

import Foundation

public struct PasscodeSetupConfiguration: PasscodeConfiguration {
    public init(canCancel: Bool, passcodeEntered: @escaping (PasscodeViewController, Bool, Int?) -> Void) {
        self.canCancel = canCancel
        self.passcodeEntered = passcodeEntered
    }

    public var passcodeEntered: (PasscodeViewController, Bool, Int?) -> Void
    public var canCancel: Bool
    
    public var type: PasscodeEntryType {
        return .setup
    }
}
