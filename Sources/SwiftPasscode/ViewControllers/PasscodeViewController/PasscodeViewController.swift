//
//  PasscodeViewController.swift
//  Passcode
//
//  Created by Alex Brown on 14/04/2020.
//  Copyright © 2020 AJB. All rights reserved.
//

#if canImport(UIKit)
import UIKit
#endif

public class PasscodeViewController: UIViewController {

    private(set) var passcodeValues = [PasscodeValueView]()
    private(set) var passcodeStackView: UIStackView?
    private(set) var passcodeCenterX: NSLayoutConstraint?
    private(set) var deleteButton: PasscodeButton?
    private(set) var passcodeTitleLabel: UILabel?
    
    var hasValues: Bool {
        return !passcodeValues.filter({ $0.hasValue }).isEmpty
    }
    
    var viewModel: PasscodeViewModel
    
    init(configuration: PasscodeConfiguration) {
        viewModel = PasscodeViewModel(configuration: configuration)
        super.init(nibName: "PasscodeViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) not supported")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        addBlurBackground()
        loadButtons()
        // Do any additional setup after loading the view.
    }

    private func addBlurBackground() {
        let effect = UIBlurEffect(style: .dark)
        let background = UIVisualEffectView(effect: effect)
        background.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(background)
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func loadButtons() {
        let buttons = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [-1, 0, -2]]
        let containerSV = UIStackView()
        containerSV.axis = .vertical
        containerSV.alignment = .fill
        containerSV.distribution = .fillProportionally
        containerSV.translatesAutoresizingMaskIntoConstraints = false
        containerSV.spacing = 15
        
        containerSV.addArrangedSubview(createPasscodeTitleLabel())
        
        containerSV.addArrangedSubview(passcodeContainer())
        for column in buttons {
            let columnSV = UIStackView()
            columnSV.translatesAutoresizingMaskIntoConstraints = false
            columnSV.axis = .horizontal
            columnSV.alignment = .fill
            columnSV.distribution = .fillEqually
            columnSV.spacing = 15
            for row in column {
                
                let button = customButton(row: row)
                viewModel.passcodeButtons.append(button)
                columnSV.addArrangedSubview(button)
            }
            containerSV.addArrangedSubview(columnSV)
        }

        view.addSubview(containerSV)

        NSLayoutConstraint.activate([
            containerSV.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerSV.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    private func createPasscodeTitleLabel() -> UILabel {
        passcodeTitleLabel = UILabel(frame: .zero)
        passcodeTitleLabel?.translatesAutoresizingMaskIntoConstraints = false
        passcodeTitleLabel?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        passcodeTitleLabel?.textAlignment = .center
        passcodeTitleLabel?.textColor = .white
        passcodeTitleLabel?.text = viewModel.title
        
        return passcodeTitleLabel!
    }
    
    func passcodeContainer() -> UIStackView {
        for _ in 0...3 {
            let placeholder = PasscodeValueView()
            passcodeValues.append(placeholder)
        }
        passcodeStackView = UIStackView(arrangedSubviews: passcodeValues)
        passcodeStackView?.axis = .horizontal
        passcodeStackView?.alignment = .fill
        passcodeStackView?.distribution = .fillEqually
        passcodeStackView?.spacing = 25
        passcodeStackView?.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView(frame: .zero)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        containerView.addSubview(passcodeStackView!)
        
        passcodeStackView!.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        passcodeCenterX = passcodeStackView!.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        passcodeCenterX!.isActive = true
        
        let containerStackView = UIStackView()
        containerStackView.axis = .vertical
        containerStackView.alignment = .fill
        containerStackView.distribution = .fill
        containerStackView.addArrangedSubview(containerView)
        
        return containerStackView
    }
    
    private func customButton(row: Int) -> PasscodeButton {
        let title = row != -1 ? "\(row)" : ""
        let button = PasscodeButton(passcodeValue: row)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(buttonSelected(sender:)), for: .touchUpInside)
        if row > -1 {
            button.layer.cornerRadius = 38
            button.backgroundColor = .clear
            let effect = UIBlurEffect(style: .light)
            let background = UIVisualEffectView(effect: effect)
            background.frame = CGRect(x: 0, y: 0, width: 76, height: 76)
            background.isUserInteractionEnabled = false
            button.insertSubview(background, at: 0)
        
        } else if row == -2 {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .light)
            deleteButton = button
            updateDeleteButtonTitle()
        }
        return button
    }
    
    func updateDeleteButtonTitle() {
        deleteButton?.setTitle(viewModel.deleteButtonTitle, for: .normal)
        if !viewModel.canCancel {
            deleteButton?.isEnabled = hasValues
        }
    }
    
    @objc func buttonSelected(sender: PasscodeButton) {
        if sender.passcodeValue > -1 {
            valueEntered(value: sender.passcodeValue)
        } else if sender.passcodeValue == -2 {
            if hasValues {
                deleteLast()
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
    }
    
    func valueEntered(value: Int) {
        let next = passcodeValues.filter({ !$0.hasValue }).first
        next?.passcodeValue = value
        viewModel.updatePasscode(with: value)
                
        deleteButton?.isEnabled = hasValues
        updateDeleteButtonTitle()
    }
        
    func incorrectPasscodeAnimation() {
        setButtonsEnabled(false)
        UIView.animateKeyframes(withDuration: 0.75, delay: 0, options: .calculationModeCubicPaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.15) {
                self.passcodeCenterX!.constant = 30
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.15, relativeDuration: 0.15) {
                self.passcodeCenterX!.constant = -30
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.1) {
                self.passcodeCenterX!.constant = 15
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.1) {
                self.passcodeCenterX!.constant = -15
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.1) {
                self.passcodeCenterX!.constant = 8
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.1) {
                self.passcodeCenterX!.constant = -3
                self.view.layoutIfNeeded()
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.05) {
                self.passcodeCenterX!.constant = 0
                self.view.layoutIfNeeded()
            }
            
        }) { complete in
            self.clearValues()
            self.setButtonsEnabled(true)
        }
    }
    
    func setButtonsEnabled(_ enabled: Bool) {
        viewModel.setButtonsEnabled(enabled)
    }
    
    func deleteLast() {
        let latest = passcodeValues.filter({ $0.hasValue }).last
        viewModel.deleteLast()
        latest?.passcodeValue = nil
        updateDeleteButtonTitle()
    }
    
    func clearValues() {
        passcodeValues.forEach({ $0.passcodeValue = nil })
        viewModel.clearPasscode()
    }
}
