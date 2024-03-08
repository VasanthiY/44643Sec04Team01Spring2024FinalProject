//
//  ProductDetails.swift
//  SmartBill
//
//  Created by Sai Ramya Gajula on 3/7/24.
//

import UIKit

class ProductDetails: UIViewController {
    
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var stepper: UIStepper!
    
    @IBOutlet weak var addBTN: UIButton!
    
    @IBOutlet weak var costLBL: UILabel!
    
    @IBOutlet weak var amount: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addBTN(_ sender: UIButton) {
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
