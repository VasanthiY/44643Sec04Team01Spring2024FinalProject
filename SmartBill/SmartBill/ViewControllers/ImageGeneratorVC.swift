//
//  ImageGeneratorVC.swift
//  SmartBill
//
//  Created by Jameer Babu on 3/31/24.
//

import UIKit
import SDWebImage
import Foundation
import SwiftUI

class ImageGeneratorVC: UIViewController {
    
    
    @IBOutlet weak var imageLink: UITextField!
    
    @IBOutlet weak var img: UIImageView!
    
    
    @IBOutlet weak var positiveprompt: UITextField!
    
    
    @IBOutlet weak var negativeprompt: UITextField!
    
    let apikey = "6e88f836e8f6c515109592d08db1826615cc614c"
//    let apikey = "a8bf0de6574d1d4d38c75acf92d6b6e09c3c433c"
    override func viewDidLoad() {
        super.viewDidLoad()
        
//                let imageUrl = "https://s3.amazonaws.com/a.storyblok.com/f/191576/1024x1024/d25e1a99d7/sample-05.png"
//                let prompt = "red background"
//                let negativePrompt = "cycles"
        // Do any additional setup after loading the view.
        
//        do {
//                print("will find desktop")
//                let desktop = try FileManager.default.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//                print("did find desktop, url: \(desktop)")
//                print("will list contents")
//                let contents = try FileManager.default.contentsOfDirectory(at: desktop, includingPropertiesForKeys: nil)
//                print("did list contents: \(contents)")
//            } catch {
//                print("did fail")
//            }
        
//        print("root: \(NSOpenStepRootDirectory())")
//        print( NSHomeDirectoryForUser("jameerbabu"))
        
//        do{
//            let image = UIImage(systemName: "homekit")
//            try image.write(to:URL(string: "~/Desktop/smartbillimages/sample.jpeg" )!)
//        }catch{
//            print("image is not saved")
//        }

        
           
    }
    
    @IBAction func generatebackground(_ sender: UIButton) {
        
        let imageUrl = imageLink.text!
        let positiveprompt = positiveprompt.text!
        let negativeprompt = negativeprompt.text!
        
        let headers = [
          "Accept": "image/png, application/json",
          "x-api-key": "5944352c1eac584f54fde98effd80c40ea8e281f"
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
            print(httpResponse)
              if (200...299).contains(httpResponse!.statusCode) {
                                              // Handle success
                  let responseBody = String(data: data!, encoding: .utf8)
                                              print("Response Body: \(responseBody ?? "No response body")")
                  if let image = UIImage(data: data!){
                    UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
                    }
              }else{
                  print("Error - HTTP Status Code: \(httpResponse!.statusCode)")
                  print("Err: \(error)")
              }
          }
        })

        dataTask.resume()
        
//        'https://image-api.photoroom.com/v2/edit?background.negativePrompt=deserts&background.prompt=rain+falling&imageUrl=https%3A%2F%2Fs3.amazonaws.com%2Fa.storyblok.com%2Ff%2F191576%2F1024x1024%2Fd25e1a99d7%2Fsample-05.png'
//        let url = URL(string: "https://image-api.photoroom.com/v2/edit?background.negativePrompt=\(negativeprompt)&background.prompt=\(positiveprompt)&imageUrl=\(imageUrl)")!
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        // Headers
//        request.setValue("image/png, application/json", forHTTPHeaderField: "Accept")
//        request.setValue("6e88f836e8f6c515109592d08db1826615cc614c", forHTTPHeaderField: "x-api-key")
//        
//                let postTask = URLSession.shared.dataTask(with: request) { data, response, error in
//                    //print(data ?? "default")
//                    guard let data = data,  let httpResponse = response as? HTTPURLResponse else {
//                                    print("Invalid data or unable to convert to UIImage")
//                                    return
//                            }
//                    if (200...299).contains(httpResponse.statusCode) {
//                            // Handle success
//                            let responseBody = String(data: data, encoding: .utf8)
//                            print("Response Body: \(responseBody ?? "No response body")")
////                        if  let image = UIImage(data: data)!.jpegData(compressionQuality: 1.0) {
////                                    // Get the documents directory URL
////                            do{
////                                try image.write(to:URL(string: "~/Desktop/smartbillimages/sample.jpeg" )!)
////                            }catch{
////                                print("image is not saved")
////                            }
////                                }
////                        if  let image = UIImage(data: data)!.jpegData(compressionQuality: 1.0) {
//                        if let image = UIImage(data: data){
//                            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
//                        }
//                        } else {
//                            // Handle non-successful status code
//                            
//                            print("Error - HTTP Status Code: \(httpResponse.statusCode)")
//                            print("Err: \(error)")
//
//                        }
//
//                }
//                postTask.resume()
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            
            print(error.localizedDescription)
            
        } else {
            
            print("Success")
        }
    }
    
    
    @IBAction func preview(_ sender: UITextField) {
        
        let imgurl = self.imageLink.text!
        self.img.sd_setImage(with: URL(string: imgurl))
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
