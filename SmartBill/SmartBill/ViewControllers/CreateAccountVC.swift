//
//  CreateAccountVC.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 3/12/24.
//

import UIKit

class CreateAccountVC: UIViewController {

    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var lockButton: UIButton!
    
    @IBOutlet weak var confirmPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onSignUp(_ sender: UIButton) {
        
        self.view.endEditing(true)
        self.validate()
            
    }
    
    func validate() ->Bool {
        
        if(self.name.text!.isEmpty) {
             showAlertAnyWhere(message: "Please enter name.")
            return false
        }
        
        if !(self.name.text!.isValidName) {
            showAlertAnyWhere(message: "Please enter valid name.")
            return false
        }
        
        
        if(!isValidEmail(testStr: email.text!)) {
             showAlertAnyWhere(message: "Please enter valid email.")
            return false
        }
        
       
        if(self.password.text!.isEmpty) {
             showAlertAnyWhere(message: "Please enter password.")
             return false
        }
        
        if(self.password.text! != self.confirmPass.text!) {
             showAlertAnyWhere(message: "Password doesn't match")
             return false
        }
        
        if(self.password.text!.count < 4 || self.password.text!.count > 20 ) {
            
            showAlertAnyWhere(message: "Password  length shoud be 4 to 20")
            return false
        }
        
        if !self.password.text!.contains(where: { $0.isUppercase }) {
            showAlertAnyWhere(message: "Password should contain at least one uppercase letter.")
            return false
        }
        
        
        
//        if !self.pass.text!.hasSpecialCharacters() {
//           showAlertAnyWhere(message: "Password should contain at least one special character.")
//           return false
//       }
        
        return true
    }


}
