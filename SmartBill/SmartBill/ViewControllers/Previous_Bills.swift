//
//  Previous_Bills.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 3/15/24.
//

import UIKit

class Previous_Bills: UIViewController {
    var currentIndex: Int = 0
    @IBOutlet weak var output_display: UITextView!
    @IBAction func Bill_Stepper(_ sender: UISegmentedControl) {
    }
    @IBOutlet weak var Stepper: UISegmentedControl!
    @IBAction func arrow_BTN(_ sender: UIButton) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      
               
        Stepper.selectedSegmentIndex = currentIndex
        // Do any additional setup after loading the view.
    }
    
    func loadPreviousBills() {
            // Example: Fetch previous bills from a database or any other source
            // Populate the `previousBills` array with the retrieved data
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
