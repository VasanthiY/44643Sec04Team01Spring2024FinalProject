import UIKit

var greeting = "Hello, playground"

let imageUrl = imageLink.text
let positiveprompt = positiveprompt.text
let negativeprompt = negativeprompt.text
let postUrl = URL(string: "https://beta-sdk.photoroom.com/v1/instant-backgrounds")!
        var postRequest = URLRequest(url: postUrl)
        postRequest.httpMethod = "POST"
        postRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        postRequest.addValue("image/jpg", forHTTPHeaderField: "accept")
        postRequest.addValue(apikey, forHTTPHeaderField: "x-api-key")
        let postBody = [
            "imageUrl": imageUrl,
            "prompt": positiveprompt,
            "negativePrompt": negativeprompt,
        ]
        postRequest.httpBody = try? JSONSerialization.data(withJSONObject: postBody, options: [])
        let postTask = URLSession.shared.dataTask(with: postRequest) { data, response, error in
            //print(data ?? "default")
            guard let data = data,  let httpResponse = response as? HTTPURLResponse else {
                            print("Invalid data or unable to convert to UIImage")
                            return
                    }
