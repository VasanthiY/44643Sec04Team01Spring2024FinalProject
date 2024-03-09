//
//  loginVCViewController.swift
//  project Ui's
//
//  Created by kalpana on 2/23/24.
//

import UIKit

class logoutVCViewController: UIViewController {

    @IBOutlet weak var displayEmail: UITextField!
    @IBOutlet weak var displayName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func showAlert(str: String) -> Void {
        
        
        let alert = UIAlertController(title: "Are you sure to exit", message: str, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
