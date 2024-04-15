//
//  AccountDetailsVC.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 3/12/24.
//

import UIKit

class logoutVCViewController: UIViewController {

    @IBAction func Logout(_ sender: UIButton) {
        if displayEmail.text == "" {
            
            self.showAlert(str: "No email to display")
            return
        }
        
        if displayName.text == "" {
            
            self.showAlert(str: "No password to display")
            return
        }
    }
    @IBOutlet weak var displayEmail: UITextField!
    
    @IBOutlet weak var displayName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func showAlert(str: String) -> Void {
        let alert = UIAlertController(title: "Are you sure to exit", message: str, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            // Perform segue when user selects "Yes"
            self.performSegue(withIdentifier: "LogoutTohome", sender: self)
        }))
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
