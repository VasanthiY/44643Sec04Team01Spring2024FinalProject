//
//  LoginVC.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 4/9/24.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet var emailAddress: UITextField!
    @IBOutlet var pwd: UITextField!
    @IBOutlet var lockBTN: UIButton!
    
    var isPasswordVisible = false
    
    @IBAction func onClickContinue(_ sender: Any) {
        if emailAddress.text!.isEmpty {
            self.displayAlert(message: "Please enter valid email address!")
            return
        }
        
        if pwd.text!.isEmpty {
            self.displayAlert(message: "Please enter valid password!")
            return
        }
        
        Task {
            do {
                try await AuthenticationManager.shared.signIn(email: emailAddress.text!, password: pwd.text!)
                FireStoreOperations.emailId = emailAddress.text!
                performSegue(withIdentifier: "successLogin", sender: self)
            } catch {
                self.displayAlert(message: "Invalid Login Credentials! Please try again.")
                return
            }
        }
    }
    
    @IBAction func onClickEye(_ sender: UIButton) {
        isPasswordVisible.toggle()
        self.pwd.isSecureTextEntry = !isPasswordVisible
        updateButtonImage()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func displayAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Credentials", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func updateButtonImage() {
        let imageName = !isPasswordVisible ? "eye.fill" : "eye.slash.fill"
        let image = UIImage(systemName: imageName)
        lockBTN.setImage(image, for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
