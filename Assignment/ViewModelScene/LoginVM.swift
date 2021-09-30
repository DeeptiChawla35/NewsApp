//
//  LoginVM.swift
//  Assignment
//
//  Created by Deepti Chawla on 28/09/21.
//

import Foundation
import KRProgressHUD
import UIKit

class LoginVM {
    
    
    func callingLoginAPI(apiName:String,target:UIViewController,completion:@escaping (_ loginStatus: Bool) -> Void){
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                KRProgressHUD.show()
                ServiceHelper.sharedInstanceHelper.createPostRequest(method: .post, showHud: true, params: nil, apiName: apiName) {  (result, error) in
                    if result != nil{
                        KRProgressHUD.dismiss()
                        
                        let fullname  = result?.value(forKey: kConstant.constants.kFullname)
                        let token = result?.value(forKey: kConstant.constants.kToken)
                        
                        completion(true)
                    }else{
                        
                        completion(false)
                    }
                }
            }
        }
    }
    
    
}

