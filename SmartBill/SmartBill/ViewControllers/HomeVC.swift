//
//  BillGen.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 3/15/24.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var welcomeLBL: UILabel!
    
    var emailId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailId = "test@gmail.com"
        Task {
            let userName = await FireStoreOperations.fetchUserName(emailId: emailId)
            welcomeLBL.text = "Welcome \(userName)"
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

}
