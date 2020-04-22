//
//  PasscodeEntryViewModel.swift
//  Passcode
//
//  Created by Alex Brown on 15/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

import Foundation

internal struct PasscodeEntryViewModel {
    
    let configuration: PasscodeEntryConfiguration
    
    private(set) var currentAttempt = 1
    
    var title: String {
        return "Enter Passcode"
    }
    
    var correctPasscode: Int {
        return configuration.correctPasscode
    }
    
    var attemptString: String {
        if hasAttemptsRemaining {
            return "Attempt \(currentAttempt) of \(configuration.numAttemps ?? 0)"
        }
        return "No Attempts Remaining"
    }
    
    var hasAttemptsRemaining: Bool {
        guard let attempts = configuration.numAttemps
            else {return true}
        
        return currentAttempt <= attempts
    }
    
    var hasMaxAttempts: Bool {
        return configuration.hasMaxAttempts
    }
    
    init(configuration: PasscodeEntryConfiguration) {
        self.configuration = configuration
    }

    func passcodeIsCorrect(passcode: Int) -> Bool {
        return passcode == correctPasscode
    }
    
    mutating func incorrectAttempt() {
        currentAttempt += 1
    }
}
