//
//  BillGen.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 3/15/24.
//

import UIKit

class BillGen: UIViewController {
    
    //let imagePredictor = ImagePredictor()
    var predictionText = ""
    let predictionsToShow = 1
    var selectedImage = UIImage()

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
        
//        present(photoPicker, animated: false)
    }
    
    @IBAction func BillGenBTN(_ sender: UIButton) {
    }
    
    
    
//    extension BillGen {
//      
//       func userSelectedPhoto(_ photo: UIImage) {
//          
//           self.selectedImage = photo
//           
//           DispatchQueue.global(qos: .userInitiated).async {
//               self.classifyImage(photo)
//           }
//       }
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}







