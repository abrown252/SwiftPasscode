//
//  PasscodeEntryViewController.swift
//  Passcode
//
//  Created by Alex Brown on 15/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif

public class PasscodeEntryViewController: PasscodeViewController {
    
    var passcodeEntryViewModel: PasscodeEntryViewModel
    var titleString: String?
    
    public init(configuration: PasscodeEntryConfiguration) {
        passcodeEntryViewModel = PasscodeEntryViewModel(configuration: configuration)
        super.init(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) not supported")
    }
        
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let title = titleString {
            passcodeTitleLabel?.text = title
        }
    }
    
    override func valueEntered(value: Int) {
        super.valueEntered(value: value)
        checkPasscodeIsCorrect()
    }
    
    private func checkPasscodeIsCorrect() {
        if passcodeValues.filter({ !$0.hasValue }).isEmpty {
            if passcodeEntryViewModel.passcodeIsCorrect(passcode: viewModel.passcodeNumber) {
                viewModel.setButtonsEnabled(false)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.viewModel.passcodeEnteredCallback(self, true, self.viewModel.passcodeNumber)
                }
            } else {
                incorrectAttempt()
            }
        }
    }
    
    private func incorrectAttempt() {
        if passcodeEntryViewModel.hasMaxAttempts {
            passcodeEntryViewModel.incorrectAttempt()
            passcodeTitleLabel?.animateTextChange(new: passcodeEntryViewModel.attemptString)
            
            if passcodeEntryViewModel.hasAttemptsRemaining {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.passcodeTitleLabel?.animateTextChange(new: self.viewModel.title)
                }
            } else {
                self.setButtonsEnabled(false)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.viewModel.passcodeEnteredCallback(self, false, self.viewModel.passcodeNumber)
                }
            }
        }
        incorrectPasscodeAnimation(enableButtons: passcodeEntryViewModel.hasAttemptsRemaining)
    }

}
