//
//  CreateAccountVC.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 3/12/24.
//

import UIKit

class CreateAccountVC: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var lockButton: UIButton!
    
    @IBOutlet weak var confirmPass: UITextField!
    
    @IBOutlet weak var messageLBL: UILabel!
    
    let specialCharacters = CharacterSet(charactersIn: "!@#$%&*")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.delegate = self
        password.isSecureTextEntry = true

        password.autocorrectionType = .no
        password.autocapitalizationType = .none
    }
    
    
    @IBAction func onSignUp(_ sender: UIButton) {
        self.view.endEditing(true)
        validateTheForm()
    }
    
    @IBAction func checkPassword(_ sender: UITextField) {
        if let checkPWD = confirmPass.text, !checkPWD.isEmpty {
            if(sender.text != checkPWD) {
                self.messageLBL.text = "Password should match!"
            } else {
                self.messageLBL.text = ""
            }
        }
    }
    
    @IBAction func confirmPassword(_ sender: UITextField) {
        if let pwd = password.text, !pwd.isEmpty {
            if(sender.text != pwd) {
                self.messageLBL.text = "Password should match!"
            } else {
                self.messageLBL.text = ""
            }
        }
    }
    
    private func validateTheForm() {
        if name.text!.isEmpty {
            self.displayAlert(message: "Please enter valid name!")
            return
        }
        
        if email.text!.isEmpty {
            self.displayAlert(message: "Please enter valid email address!")
            return
        }
        
        if password.text!.isEmpty {
            self.displayAlert(message: "Please enter valid password!")
            return
        }
        
        if(password.text!.count < 4 || password.text!.count > 20 ) {
            self.displayAlert(message: "Password length shoud be 4 to 20!")
            return
        }
        
        if !password.text!.contains(where: { $0.isUppercase }) {
            self.displayAlert(message: "Password should contain at least one uppercase letter.")
            return
        }
        
        let isSplCharacter: Bool = self.containsSpecialCharacter(in: password.text!)

        if !isSplCharacter {
            self.displayAlert(message: "Password should contain at least one special character among !@#$%&*.")
            return
        }
        
        if confirmPass.text!.isEmpty {
            self.displayAlert(message: "Both the passwords should match!")
            return
        }
        
        Task {
            do {
                try await AuthenticationManager.shared.createUser(email: email.text!, password: password.text!)
                performSegue(withIdentifier: "CreateToLoginSegue", sender: self)
            } catch {
                return
            }
        }
    }
    
    func containsSpecialCharacter(in string: String) -> Bool {
        for character in string {
            if specialCharacters.contains(character.unicodeScalars.first!) {
                return true
            }
        }

        return false
    }
    
    private func displayAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Entry", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
