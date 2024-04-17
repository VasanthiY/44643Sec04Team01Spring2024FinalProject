//
//  BillGen.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 3/15/24.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var welcomeLBL: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            await FireStoreOperations.fetchUserName()
            welcomeLBL.text = "Welcome \(FireStoreOperations.userName)"
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
