import UIKit

var greeting = "Hello, playground"

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
