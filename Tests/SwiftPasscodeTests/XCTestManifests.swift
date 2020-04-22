import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(PasscodeViewModelTests.allTests),
        testCase(PasscodeSetupViewModelTests.allTests),
        testCase(PasscodeEntryViewModelTests.allTests)
    ]
}
#endif
