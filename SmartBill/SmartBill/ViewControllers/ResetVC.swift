//
//  ResetVC.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 4/11/24.
//

import UIKit

class ResetVC: UIViewController {
    
    @IBOutlet weak var emailAddress: UITextField!
    
    @IBOutlet weak var sendLinkButton: UIButton!
    
    @IBOutlet weak var cancelBTN: UIButton!
    
    @IBAction func onClickSendLink(_ sender: Any) {
        if let email = emailAddress.text, email.isEmpty {
            self.displayAlert(message: "Please enter valid email address!")
            return
        }
        
        Task {
            do {
                try await AuthenticationManager.shared.resetPassword(email: emailAddress.text!)
                performSegue(withIdentifier: "resetPasswordToLogin", sender: self)
            }
        }
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        performSegue(withIdentifier: "resetPasswordToLogin", sender: self)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
