//
//  UploadImageVC.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 3/15/24.
//  Modified by Jameer Babu on 3/31/24.
//

import UIKit
import AVFoundation
import Vision

class UploadImageVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var detectedObjects = [String]()
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var itemLBL: UILabel!
    
    @IBOutlet weak var addToCartBTN: UIButton!
    
    @IBOutlet weak var viewCartBTN: UIBarButtonItem!
    
    @IBAction func addToCart(_ sender: UIButton) {
        performSegue(withIdentifier: "showBillDetails", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToCartBTN.isEnabled = false
        addToCartBTN.isUserInteractionEnabled = false
        addToCartBTN.backgroundColor = UIColor.gray
        
        viewCartBTN.isHidden = true

        // Do any additional setup after loading the view.
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        img.addGestureRecognizer(doubleTapGesture)
        
        img.isUserInteractionEnabled = true
    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "showBillDetails" || segue.identifier == "showCartItems"){
//            let destinationVC = segue.destination as! BillDetailTVC
//            destinationVC.bills = matchedObjects
//        }
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selImg = info[.editedImage] as? UIImage {
            AudioServicesPlaySystemSound(1109)
            img.image = selImg
        }
        self.detectedObjects = []
        performObjectDetection(img.image!)
        matchObjects()
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.img.image = UIImage(named: "uploadimagepic")
        self.itemLBL.text = ""
        
        addToCartBTN.isEnabled = false
        addToCartBTN.isUserInteractionEnabled = false
        addToCartBTN.backgroundColor = UIColor.gray
        
        if !FireStoreOperations.cartItems.isEmpty {
            viewCartBTN.isHidden = false
        }
    }
    
    @objc func doubleTapGesture(_ gesture: UITapGestureRecognizer) {
        AudioServicesPlaySystemSound(1104)
        if gesture.state == .ended {
            let imgCtrler = UIImagePickerController()
            imgCtrler.delegate = self
            imgCtrler.allowsEditing = true
            imgCtrler.sourceType = .photoLibrary
            present(imgCtrler, animated: true, completion: nil)
        }
    }
    
    
    func performObjectDetection(_ image: UIImage) {
        guard let ciImage = CIImage(image: image) else {
            fatalError("Unable to create CIImage from UIImage")
        }
        do {
            // Perform the text-recognition request.
            let imgHandler = VNImageRequestHandler(ciImage: ciImage)

            let request = VNRecognizeTextRequest { (request, error) in
                guard let observations = request.results as? [VNRecognizedTextObservation] else { return }

                for currentObservation in observations {
                    /// The 1 in topCandidates(1) indicates that we only want one candidate.
                    /// After that we take our one and only candidate with the most confidence out of the array.
                    let topCandidate = currentObservation.topCandidates(1).first
                    self.detectedObjects.append(topCandidate!.string)
                }

                self.addToCartBTN.isEnabled = true
                self.addToCartBTN.isUserInteractionEnabled = true
                self.addToCartBTN.backgroundColor = UIColor.systemBlue
            }
            
            request.recognitionLanguages = ["en"]
            request.recognitionLevel = .accurate
            request.usesLanguageCorrection = true

            try imgHandler.perform([request])
        } catch {
            print("Unable to perform the requests: \(error).")
        }
    }
    
    
    func matchObjects(){
        let productsindb = FireStoreOperations.productnames
        let specialchars = "-"
        for detectedObject in detectedObjects {
            let obj = detectedObject.lowercased().replacing(specialchars, with: "")
            if(productsindb.contains(obj)){
                FireStoreOperations.cartItems[obj, default: 0] += 1
                self.itemLBL.text = obj
            }
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
