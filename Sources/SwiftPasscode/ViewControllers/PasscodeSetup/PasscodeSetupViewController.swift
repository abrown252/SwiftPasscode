//
//  PasscodeSetupViewController.swift
//  Passcode
//
//  Created by Alex Brown on 15/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif

public class PasscodeSetupViewController: PasscodeViewController {

    private var passcodeSetupViewModel: PasscodeSetupViewModel
    
    public init(configuration: PasscodeSetupConfiguration) {
        passcodeSetupViewModel = PasscodeSetupViewModel(configuration: configuration)
        super.init(configuration: configuration)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) not supported")
    }
    
    override func valueEntered(value: Int) {
        super.valueEntered(value: value)
        guard viewModel.canEnterValues
            else {return}
        
        checkPasscodeEntry()
    }
    
    private func checkPasscodeEntry() {
        if passcodeValues.filter({ !$0.hasValue }).isEmpty {
            if viewModel.passcodeValues.count == 4 {
                if !passcodeSetupViewModel.hasFirstPasscode {
                    passcodeSetupViewModel.firstPasscode = viewModel.passcodeValues
                    passcodeTitleLabel?.animateTextChange(new: "Re-enter Passcode")
                    clearValues()
                } else {
                    passcodeSetupViewModel.secondPasscode = viewModel.passcodeValues
                    checkPasscodesMatch()
                }
            }
        }
    }
    
    private func checkPasscodesMatch() {
        if passcodeSetupViewModel.passcodesAreEqual {
            viewModel.setButtonsEnabled(false)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.viewModel.passcodeEnteredCallback(self, true, self.viewModel.passcodeNumber)
            }
        } else {
            incorrectAttempt()
            passcodeSetupViewModel.reset()
        }
    }
    
    private func incorrectAttempt() {
        passcodeTitleLabel?.animateTextChange(new: "Passcodes do not match")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.passcodeTitleLabel?.animateTextChange(new: self.viewModel.title)
        }
        clearValues()
        incorrectPasscodeAnimation()
    }
}
