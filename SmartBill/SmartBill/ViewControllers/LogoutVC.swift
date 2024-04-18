//
//  AccountDetailsVC.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 3/12/24.
//

import UIKit

class LogoutVC: UIViewController {

    
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var fullName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fullName.text = FireStoreOperations.userName
        emailId.text = FireStoreOperations.emailId
    }
    

    @IBAction func logout(_ sender: Any) {
        self.showAlert()
        let systemSound: SystemSoundID = 1054
        AudioServicesPlaySystemSound(systemSound)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Logout", message: "Would you like to logout?", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] (action) in
            let systemSound: SystemSoundID = 1005
                    AudioServicesPlaySystemSound(systemSound)
            Task {
                try AuthenticationManager.shared.signOut()
                self?.performSegue(withIdentifier: "backToLogin", sender: self)
            }
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
