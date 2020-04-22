//
//  PasscodeConfiguration.swift
//  Passcode
//
//  Created by Alex Brown on 15/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

import Foundation

public enum PasscodeEntryType {
    case setup
    case entry
}
public protocol PasscodeConfiguration {
    var type: PasscodeEntryType {get}
    var passcodeEntered: (PasscodeViewController, Bool, Int) -> Void {get set}
    var canCancel: Bool {get set}
}
