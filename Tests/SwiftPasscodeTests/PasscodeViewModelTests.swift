//
//  PasscodeViewModelTests.swift
//  BACSOutcomesTests
//
//  Created by Alex Brown on 20/04/2020.
//  Copyright © 2020 K2M, Inc. All rights reserved.
//

import XCTest
@testable import SwiftPasscode

final class PasscodeViewModelTests: XCTestCase {
    
    var setupViewModel: PasscodeViewModel!
    var entryViewModel: PasscodeViewModel!
        
    override func setUpWithError() throws {
        let setupConfig = PasscodeSetupConfiguration(canCancel: true) { (_, _, _) in }
        setupViewModel = PasscodeViewModel(configuration: setupConfig)
        
        let entryConfig = PasscodeEntryConfiguration(canCancel: false, numAttempts: 3, correctPasscode: 1234) { (_, _, _) in }
        entryViewModel = PasscodeViewModel(configuration: entryConfig)
        
        let limit: Int = 4
        for i in 0...limit {
            let button = PasscodeButton(passcodeValue: i)
            setupViewModel!.passcodeButtons.append(button)
            entryViewModel!.passcodeButtons.append(button)
        }
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPasscodeNumber() {
        setupViewModel.updatePasscode(with: 1)
        setupViewModel.updatePasscode(with: 5)
        setupViewModel.updatePasscode(with: 4)
        setupViewModel.updatePasscode(with: 2)
        XCTAssertEqual(1542, setupViewModel?.passcodeNumber)
    }
    
    func testTitle() {
        XCTAssertEqual(setupViewModel.title, "Change Passcode")
        XCTAssertEqual(entryViewModel.title, "Enter Passcode")
    }
    
    func testEntryType() {
        XCTAssertEqual(setupViewModel.entryType, PasscodeEntryType.setup)
        XCTAssertEqual(entryViewModel.entryType, PasscodeEntryType.entry)
    }
        
    func testCanCancel() {
        XCTAssertTrue(setupViewModel.canCancel)
        XCTAssertFalse(entryViewModel.canCancel)
    }

    func testDeleteButtonTitle_whenEmptyPasscodeValues() {
        XCTAssertEqual(setupViewModel.deleteButtonTitle, "Cancel")
        XCTAssertEqual(entryViewModel.deleteButtonTitle, "Delete")
    }
    
    func testDeleteButtonTitle_whenPasscodeValues() {
        setupViewModel.updatePasscode(with: 1)
        entryViewModel.updatePasscode(with: 1)
        
        XCTAssertEqual(setupViewModel.deleteButtonTitle, "Delete")
        XCTAssertEqual(entryViewModel.deleteButtonTitle, "Delete")
    }
    
    func testSetButtonsEnabled_enabled() {
        setupViewModel.setButtonsEnabled(true)
        XCTAssertTrue(setupViewModel.passcodeButtons[1].isEnabled)
    }
    
    func testSetButtonsEnabled_disabled() {
        setupViewModel.setButtonsEnabled(false)
        XCTAssertFalse(setupViewModel.passcodeButtons[1].isEnabled)
    }
    
    func testUpdatePasscode() {
        setupViewModel.updatePasscode(with: 7)
        setupViewModel.updatePasscode(with: 5)
        
        XCTAssertTrue(setupViewModel.passcodeValues.contains(7))
        XCTAssertTrue(setupViewModel.passcodeValues.contains(5))
    }
    
    func testClearPasscode() {
        setupViewModel.updatePasscode(with: 7)
        setupViewModel.updatePasscode(with: 5)
        setupViewModel.clearPasscode()
        
        XCTAssertTrue(setupViewModel.passcodeValues.isEmpty)
    }
    
    func testDeleteLast() {
        setupViewModel.updatePasscode(with: 7)
        setupViewModel.updatePasscode(with: 5)
        setupViewModel.deleteLast()
        
        XCTAssertFalse(setupViewModel.passcodeValues.contains(5))
    }
    
    static var allTests = [
        ("testPasscodeNumber", testPasscodeNumber),
        ("testTitle", testTitle),
        ("testEntryType", testEntryType),
        ("testCanCancel", testCanCancel),
        ("testDeleteButtonTitle_whenEmptyPasscodeValues", testDeleteButtonTitle_whenEmptyPasscodeValues),
        ("testDeleteButtonTitle_whenPasscodeValues", testDeleteButtonTitle_whenPasscodeValues),
        ("testSetButtonsEnabled_enabled", testSetButtonsEnabled_enabled),
        ("testSetButtonsEnabled_disabled", testSetButtonsEnabled_disabled),
        ("testUpdatePasscode", testUpdatePasscode),
        ("testClearPasscode", testClearPasscode),
        ("testDeleteLast", testDeleteLast)
    ]
}
