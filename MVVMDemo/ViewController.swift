//
//  ViewController.swift
//  MVVMDemo
//
//  Created by Panpan Han  on 2019/7/23.
//  Copyright © 2019 PanpanHan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    private var viewModel = UserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configTextFields()
    }

    @IBAction func login(_ sender: Any) {
        authenticate()
    }

    private func configTextFields() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func authenticate() {
        view.endEditing(true)

        viewModel.login { title, message in
            showMessage(title: title, message: message)
        }

    }

    private func showMessage(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textField == usernameTextField {
            viewModel.username = newString
        } else if textField == passwordTextField {
            viewModel.password = newString
        }
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            textField.text = viewModel.username
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTextField {
            textField.text = viewModel.protectedUsername
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            authenticate()
        }
        return true
    }
}

