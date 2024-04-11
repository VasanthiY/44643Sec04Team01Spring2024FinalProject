

import Foundation


extension String {
    var isValidName: Bool {
        let nameRegex = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegex)
        return nameTest.evaluate(with: self)
    }
}

func isValidEmail(testStr:String) -> Bool {
// print("validate calendar: \(testStr)")
let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
return emailTest.evaluate(with: testStr)
}
