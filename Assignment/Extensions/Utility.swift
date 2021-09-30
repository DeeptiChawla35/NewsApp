//
//  Utility.swift

//

import Foundation

func notnull(_ key:String,_ dataArray:[String:Any]) -> String {
    if  dataArray[key] as? String  != nil {
        return dataArray[key] as! String
    }
    else{
        return ""
    }
}

func notnullInt(_ key:String,_ dataArray:[String:Any]) -> Int {
    if  dataArray[key] as? Int  != nil {
        return dataArray[key] as! Int
    }
    else{
        return 0
    }
}


func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

func isValidPassword(_ password:String) -> Bool {
   if(password.count > 7 && password.count < 17) {
   } else {
       return false
   }
   let nonUpperCase = CharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZ").inverted
   let letters = password.components(separatedBy: nonUpperCase)
   let strUpper: String = letters.joined()

   let smallLetterRegEx  = ".*[a-z]+.*"
   let samlltest = NSPredicate(format:"SELF MATCHES %@", smallLetterRegEx)
   let smallresult = samlltest.evaluate(with: password)

   let numberRegEx  = ".*[0-9]+.*"
   let numbertest = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
   let numberresult = numbertest.evaluate(with: password)

   let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z0-9].*", options: NSRegularExpression.Options())
   var isSpecial :Bool = false
   if regex.firstMatch(in: password, options: NSRegularExpression.MatchingOptions(), range:NSMakeRange(0, password.count)) != nil {
    print("could not handle special characters")
       isSpecial = true
   }else{
       isSpecial = false
   }
   return (strUpper.count >= 1) && smallresult && numberresult && isSpecial
}
