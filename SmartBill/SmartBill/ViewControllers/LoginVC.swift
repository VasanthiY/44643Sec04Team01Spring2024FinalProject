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
    
    @IBAction func onClickContinue(_ sender: Any) {
        if emailAddress.text!.isEmpty {
            self.displayAlert(message: "Please enter valid email address!")
            return
        }
        
        if pwd.text!.isEmpty {
            self.displayAlert(message: "Please enter valid password!")
            return
        }
        
        performSegue(withIdentifier: "successLogin", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showSessionExpireAlert() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showAlert(message:  "Session expired")
        }
    }
    
    private func displayAlert(message: String) {
        let alert = UIAlertController(title: "Invalid Credentials", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
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
