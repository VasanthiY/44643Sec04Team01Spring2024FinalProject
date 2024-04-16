//
//  UploadImageVC.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 3/15/24.
//  Modified by Jameer Babu on 3/31/24.
//

import UIKit

class UploadImageVC: UIViewController {

    var detectedObjects = [String]()
    var matchedObjects = [String:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture(_:)))
        doubleTapGesture.numberOfTapsRequired = 2
        img.addGestureRecognizer(doubleTapGesture)
        
        img.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showBillDetails"){
            let destinationVC = segue.destination as! BillDetailTVC
            destinationVC.bills = matchedObjects
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selImg = info[.editedImage] as? UIImage {
            AudioServicesPlaySystemSound(1109)
            img.image = selImg
        }
        
        picker.dismiss(animated: true, completion: nil)
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

                            //print(topCandidate?.string)
                            self.detectedObjects.append(topCandidate!.string)
                        }
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
            print("cleared:\(obj)")
            if(productsindb.contains(obj)){
                matchedObjects[obj, default: 0] += 1
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
