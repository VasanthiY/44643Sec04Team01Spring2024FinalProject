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
        
        present(photoPicker, animated: false)
    }
    
    @IBAction func BillGenBTN(_ sender: UIButton) {
    }
    
}
    
    
    extension BillGen {
      

       func userSelectedPhoto(_ photo: UIImage) {
          
           self.selectedImage = photo
           
           DispatchQueue.global(qos: .userInitiated).async {
               self.classifyImage(photo)
           }
       }

    }

    extension BillGen {
        
       private func classifyImage(_ image: UIImage) {
           do {
               try self.imagePredictor.makePredictions(for: image,
                                                       completionHandler: imagePredictionHandler)
           } catch {
               print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
           }
       }

      
       private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
           guard let predictions = predictions else {
               
               DispatchQueue.main.async { [self] in
                   let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
                   vc.image = selectedImage
                   vc.predictionText = "No Details"
                   self.navigationController?.pushViewController(vc, animated: true)
                  
               }
               
               return
           }

           let formattedPredictions = formatPredictions(predictions)

           let predictionString = formattedPredictions.joined(separator: "\n")
           
           DispatchQueue.main.async {
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
               vc.image = self.selectedImage
               vc.predictionText = predictionString
               self.navigationController?.pushViewController(vc, animated: true)
              
           }
           
       }

     
       private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
           // Vision sorts the classifications in descending confidence order.
           let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
               var name = prediction.classification

               
               if let firstComma = name.firstIndex(of: ",") {
                   name = String(name.prefix(upTo: firstComma))
               }

               return "\(name)"
           }

           return topPredictions
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



import UIKit

class HomeVC: UIViewController {
  
   let imagePredictor = ImagePredictor()
   var predictionText = ""
   let predictionsToShow = 1
   var selectedImage = UIImage()
   
   @IBAction func onScan() {
   
       present(photoPicker, animated: false)

   }
   
}


extension HomeVC {
  

   func userSelectedPhoto(_ photo: UIImage) {
      
       self.selectedImage = photo
       
       DispatchQueue.global(qos: .userInitiated).async {
           self.classifyImage(photo)
       }
   }

}

extension HomeVC {
    
   private func classifyImage(_ image: UIImage) {
       do {
           try self.imagePredictor.makePredictions(for: image,
                                                   completionHandler: imagePredictionHandler)
       } catch {
           print("Vision was unable to make a prediction...\n\n\(error.localizedDescription)")
       }
   }

  
   private func imagePredictionHandler(_ predictions: [ImagePredictor.Prediction]?) {
       guard let predictions = predictions else {
           
           DispatchQueue.main.async { [self] in
               let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
               vc.image = selectedImage
               vc.predictionText = "No Details"
               self.navigationController?.pushViewController(vc, animated: true)
              
           }
           
           return
       }

       let formattedPredictions = formatPredictions(predictions)

       let predictionString = formattedPredictions.joined(separator: "\n")
       
       DispatchQueue.main.async {
           let vc = self.storyboard?.instantiateViewController(withIdentifier: "ItemDetailsVC") as! ItemDetailsVC
           vc.image = self.selectedImage
           vc.predictionText = predictionString
           self.navigationController?.pushViewController(vc, animated: true)
          
       }
       
   }

 
   private func formatPredictions(_ predictions: [ImagePredictor.Prediction]) -> [String] {
       // Vision sorts the classifications in descending confidence order.
       let topPredictions: [String] = predictions.prefix(predictionsToShow).map { prediction in
           var name = prediction.classification

           
           if let firstComma = name.firstIndex(of: ",") {
               name = String(name.prefix(upTo: firstComma))
           }

           return "\(name)"
       }

       return topPredictions
   }
}






