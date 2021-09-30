//
//  ShowAlert.swift


import Foundation
import Foundation
import UIKit

class ShowAlert {
    
    func showAlert(_ target:UIViewController,message:String){
        let alert = UIAlertController(title: kConstant.constants.kAlert, message: message, preferredStyle: UIAlertController.Style.alert)
        
       
        alert.addAction(UIAlertAction(title:kConstant.constants.kOK,
                                      style: UIAlertAction.Style.default,
                                      handler: {(_: UIAlertAction!) in
            target.dismiss(animated: true, completion: nil)
                                      }))
        target.present(alert, animated: true, completion: nil)
    }
   
}
