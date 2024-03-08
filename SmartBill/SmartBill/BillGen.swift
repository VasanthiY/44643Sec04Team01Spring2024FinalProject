//
//  BillGen.swift
//  SmartBill
//
//  Created by Sai Ramya Gajula on 2/22/24.
//

import UIKit

class BillGen: UIViewController {

    
    @IBOutlet weak var BillBTN: UIButton!
    
    @IBOutlet weak var titleLBL: UILabel!
    
    
    @IBOutlet weak var prevBillBTN: UIButton!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        BillBTN.isEnabled = true
        prevBillBTN.isEnabled = true
        
    }
    
   
    @IBAction func prevBillBTN(_ sender: UIButton) {
    }
    
    
    @IBAction func BillGenBTN(_ sender: UIButton) {
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
