//
//  ResetVC.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 4/11/24.
//

import UIKit
import AVFoundation

class ResetVC: UIViewController {
    
    let continueSound: SystemSoundID = 1109
    let errorSound: SystemSoundID = 1152
    
    @IBOutlet weak var emailAddress: UITextField!
    
    @IBOutlet weak var sendLinkButton: UIButton!
    
    @IBOutlet weak var cancelBTN: UIButton!
    
    @IBAction func onClickSendLink(_ sender: Any) {
        if let email = emailAddress.text, email.isEmpty {
            self.displayAlert(message: "Please enter valid email address!")
            AudioServicesPlaySystemSound(errorSound)
            return
        }
        
        Task {
            do {
                try await AuthenticationManager.shared.resetPassword(email: emailAddress.text!)
                AudioServicesPlaySystemSound(continueSound)
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
