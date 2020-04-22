//
//  PasscodeSetupViewModel.swift
//  BACSOutcomesTests
//
//  Created by Alex Brown on 20/04/2020.
//  Copyright © 2020 K2M, Inc. All rights reserved.
//

import XCTest
@testable import SwiftPasscode

final class PasscodeSetupViewModelTests: XCTestCase {
    
    var viewModel: PasscodeSetupViewModel!
        
    override func setUpWithError() throws {
        let setupConfig = PasscodeSetupConfiguration(canCancel: true) { (_, _, _) in }
        viewModel = PasscodeSetupViewModel(configuration: setupConfig)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPasscodesAreEqual_true() {
        viewModel.firstPasscode = [1, 2, 3, 4]
        viewModel.secondPasscode = [1, 2, 3, 4]
        
        XCTAssertTrue(viewModel.passcodesAreEqual)
    }
    
    func testPasscodesAreEqual_false() {
        viewModel.firstPasscode = [1, 2, 3, 4]
        viewModel.secondPasscode = [1, 2, 3, 5]
        
        XCTAssertFalse(viewModel.passcodesAreEqual)
    }
    
    func testHasFirstPasscode_true() {
        viewModel.firstPasscode = [1, 2, 3, 4]
        XCTAssertTrue(viewModel.hasFirstPasscode)
    }
    
    func testHasFirstPasscode_false() {
        viewModel.firstPasscode = []
        XCTAssertFalse(viewModel.hasFirstPasscode)
    }
    
    func testHasFirstPasscode_false_invalidCount() {
        viewModel.firstPasscode = [1, 2, 3]
        XCTAssertFalse(viewModel.hasFirstPasscode)
    }
    
    func testHasSecondPasscode_true() {
        viewModel.secondPasscode = [1, 2, 3, 4]
        XCTAssertTrue(viewModel.hasSecondPasscode)
    }
    
    func testHasSecondPasscode_false() {
        viewModel.secondPasscode = []
        XCTAssertFalse(viewModel.hasSecondPasscode)
    }
    func testHasSecondPasscode_false_invalidCount() {
        viewModel.secondPasscode = [1, 2, 3]
        XCTAssertFalse(viewModel.hasSecondPasscode)
    }
    
    func testReset() {
        viewModel.firstPasscode = [0, 1, 2, 3]
        viewModel.secondPasscode = [0, 1, 2, 3]
        
        viewModel.reset()
        
        XCTAssertTrue(viewModel.firstPasscode.isEmpty)
        XCTAssertTrue(viewModel.secondPasscode.isEmpty)
    }

    static var allTests = [
        ("testPasscodesAreEqual_true", testPasscodesAreEqual_true),
        ("testPasscodesAreEqual_false", testPasscodesAreEqual_false),
        ("testHasFirstPasscode_true ", testHasFirstPasscode_true ),
        ("testHasFirstPasscode_false", testHasFirstPasscode_false),
        ("testHasFirstPasscode_false_invalidCount", testHasFirstPasscode_false_invalidCount),
        ("testHasSecondPasscode_true", testHasSecondPasscode_true),
        ("testHasSecondPasscode_false", testHasSecondPasscode_false),
        ("testHasSecondPasscode_false_invalidCount", testHasSecondPasscode_false_invalidCount),
        ("testReset", testReset)
    ]
}
