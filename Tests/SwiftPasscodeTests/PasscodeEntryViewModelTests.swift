//
//  PasscodeEntryViewModelTests.swift
//  BACSOutcomesTests
//
//  Created by Alex Brown on 20/04/2020.
//  Copyright © 2020 K2M, Inc. All rights reserved.
//

import XCTest
@testable import SwiftPasscode

final class PasscodeEntryViewModelTests: XCTestCase {
    
    var viewModel: PasscodeEntryViewModel!
        
    override func setUpWithError() throws {
        let entryConfig = PasscodeEntryConfiguration(canCancel: false, numAttempts: 3, correctPasscode: 1234) { (_, _, _) in }
        viewModel = PasscodeEntryViewModel(configuration: entryConfig)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTitle() {
        XCTAssertEqual(viewModel.title, "Enter Passcode")
    }
    
    func testCorrectPasscode() {
        XCTAssertEqual(viewModel.correctPasscode, 1234)
    }

    func testAttemptString() {
        viewModel.incorrectAttempt()
        
        XCTAssertEqual(viewModel.attemptString, "Attempt 2 of 3")
    }
    
    func testAttemptString_noAttempts() {
        viewModel.incorrectAttempt()
        viewModel.incorrectAttempt()
        viewModel.incorrectAttempt()
        
        XCTAssertEqual(viewModel.attemptString, "No Attempts Remaining")
    }
    
    func testHasAttemptsRemaining_true() {
        XCTAssertTrue(viewModel.hasAttemptsRemaining)
    }
    
    func testHasAttemptsRemaining_false() {
        viewModel.incorrectAttempt()
        viewModel.incorrectAttempt()
        viewModel.incorrectAttempt()
        XCTAssertFalse(viewModel.hasAttemptsRemaining)
    }
    
    func testHasmasAttempts() {
        XCTAssertTrue(viewModel.hasMaxAttempts)
    }
    
    func testPasscodeIsCorrect_true() {
        XCTAssertTrue(viewModel.passcodeIsCorrect(passcode: 1234))
    }
    
    func testPasscodeIsCorrect_false() {
        XCTAssertFalse(viewModel.passcodeIsCorrect(passcode: 1111))
    }
    
    func testIncorrectAttempt() {
        viewModel.incorrectAttempt()
        XCTAssertEqual(viewModel.currentAttempt, 2)
    }
    
    static var allTests = [
        ("testTitle", testTitle),
        ("testCorrectPasscode", testCorrectPasscode),
        ("testAttemptString", testAttemptString),
        ("testAttemptString_noAttempts", testAttemptString_noAttempts),
        ("testHasAttemptsRemaining_true", testHasAttemptsRemaining_true),
        ("testHasAttemptsRemaining_false", testHasAttemptsRemaining_false),
        ("testHasmasAttempts", testHasmasAttempts),
        ("testPasscodeIsCorrect_true", testPasscodeIsCorrect_true),
        ("testPasscodeIsCorrect_false", testPasscodeIsCorrect_false),
        ("testIncorrectAttempt", testIncorrectAttempt)
    ]
}
