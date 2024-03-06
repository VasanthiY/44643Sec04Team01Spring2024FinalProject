//
//  ImageBGController.swift
//  SmartBill
//
//  Created by Jameer Babu on 3/5/24.
//

import UIKit
import Foundation

class ImageBGController: UIViewController {
    
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        let apiKey = "6e88f836e8f6c515109592d08db1826615cc614c"
        let imageUrl = "https://s3.amazonaws.com/a.storyblok.com/f/191576/1024x1024/d25e1a99d7/sample-05.png"
        let prompt = "red background"
        let negativePrompt = "cycles"

        /// POST request
        let postUrl = URL(string: "https://beta-sdk.photoroom.com/v1/instant-backgrounds")!
        var postRequest = URLRequest(url: postUrl)
        postRequest.httpMethod = "POST"
        postRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        postRequest.addValue("image/jpg", forHTTPHeaderField: "accept")
        postRequest.addValue(apiKey, forHTTPHeaderField: "x-api-key")
        let postBody = [
            "imageUrl": imageUrl,
            "prompt": prompt,
            "negativePrompt": negativePrompt,
        ]
        postRequest.httpBody = try? JSONSerialization.data(withJSONObject: postBody, options: [])
        let postTask = URLSession.shared.dataTask(with: postRequest) { data, response, error in
            //print(data ?? "default")
            guard let data = data,  let httpResponse = response as? HTTPURLResponse else {
                            print("Invalid data or unable to convert to UIImage")
                            return
                    }
            if (200...299).contains(httpResponse.statusCode) {
                    // Handle success
                    let responseBody = String(data: data, encoding: .utf8)
                    print("Response Body: \(responseBody ?? "No response body")")
                if  let image = UIImage(data: data)!.jpegData(compressionQuality: 1.0) {
                            // Get the documents directory URL
                            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                                // Create a unique filename
                                print(": \(documentsDirectory.description)")
                                let filename = documentsDirectory.appendingPathComponent("savedImage.jpg")
                                

                                // Save the image data to a file
                                do {
                                    try image.write(to: filename)
                                    print("Image saved successfully at: \(filename)")
                                } catch {
                                    print("Error saving image: \(error)")
                                }
                            }
                        }
                } else {
                    // Handle non-successful status code
                    print("Error - HTTP Status Code: \(httpResponse.statusCode)")
                    
                }
            
        }
        postTask.resume()

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
