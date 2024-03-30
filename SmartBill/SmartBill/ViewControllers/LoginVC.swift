//
//  Login.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 2/20/24.
//

import UIKit

class LoginVC: UIViewController {

    
    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var emailId: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        
    }
    
    
    
    @IBAction func onLogin(_ sender: UIButton) {
        let email = emailId.text!.lowercased()
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC")
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    func showSessionExpireAlert() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showAlert(message:  "Session expired")
        }
        
    }
    
    
    @IBAction func onSignUp(_ sender: UIButton) {
    }
    
   

}

extension LoginVC {
    
    
    func setLockImage() {
        
        self.password.isSecureTextEntry =  !self.password.isSecureTextEntry
        
        if(self.password.isSecureTextEntry) {
            self.lockButton.setImage(UIImage(systemName: "lock"), for: .normal)
        }else {
            self.lockButton.setImage(UIImage(systemName: "lock.open"), for: .normal)
        }
    }
   
    @IBAction func onLockUnlock(_ sender: Any) {
        
        setLockImage()
    }
    
}
