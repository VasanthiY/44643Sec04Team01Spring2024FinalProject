//
//  AddProductVC.swift
//  SmartBill
//
//  Created by Krishna Vasanthi on 4/18/24.
//

import UIKit
import SDWebImage
import Foundation
import SwiftUI

class AddProductVC: UIViewController {
    
    let apikey = "6e88f836e8f6c515109592d08db1826615cc614c"

    @IBOutlet weak var imageLinkTF: UITextField!
    
    @IBOutlet weak var productIV: UIImageView!
    
    @IBOutlet weak var positivePromptTF: UITextField!
    
    @IBOutlet weak var negativePromptTF: UITextField!
    
    @IBAction func onClickAddProduct(_ sender: Any) {
        
//        https://s3.amazonaws.com/a.storyblok.com/f/191576/1024x1024/d25e1a99d7/sample-05.png
        let imageUrl = imageLinkTF.text!
        let positiveprompt = positivePromptTF.text!
        let negativeprompt = negativePromptTF.text!
        
        let headers = [
          "Accept": "image/png, application/json",
          "x-api-key": "4e921dcd5f1a62ffa4c3847637b18fb7e8cb1cd7"
          /*- This needs to be replaced for every 10 images as we are using trail period.*/
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://image-api.photoroom.com/v2/edit?background.negativePrompt=\(negativeprompt)&background.prompt=\(positiveprompt)&imageUrl=\(imageUrl)")! as URL,
        cachePolicy: .useProtocolCachePolicy,
        timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
          if (error != nil) {
            print(error as Any)
          } else {
            let httpResponse = response as? HTTPURLResponse
//            print(httpResponse)
              if (200...299).contains(httpResponse!.statusCode) {
                                              // Handle success
                  let responseBody = String(data: data!, encoding: .utf8)
                                              print("Response Body: \(responseBody ?? "No response body")")
                  if let image = UIImage(data: data!){
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                    }
              } else{
//                  print("Error - HTTP Status Code: \(httpResponse!.statusCode)")
//                  print("Err: \(error)")
              }
          }
        })

        dataTask.resume()
    }
    
    @IBAction func generateImage(_ sender: Any) {
        let imgurl = self.imageLinkTF.text!
        self.productIV.sd_setImage(with: URL(string: imgurl))
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("Success")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
