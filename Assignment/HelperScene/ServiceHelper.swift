//
//  ServiceHelper.swift


import Foundation
import Alamofire
import KRProgressHUD


public final class ServiceHelper {
   
    let BASE_URL = kConstant.constants.kBaseURL
    public class var sharedInstanceHelper: ServiceHelper {
        struct Static {
            static let instance = ServiceHelper()
        }
        return Static.instance
    }
    
    
    public func createPostRequest(method: HTTPMethod,showHud :Bool, params: [String: Int]!, apiName: String, completionHandler:@escaping (_ response: AnyObject?, _ error: NSError?) -> Void) {
        
        if Reachability.init().isConnectedToNetwork() {
       
            var url = String()
            
            url = kConstant.constants.kBaseURL + apiName
         
        
            Alamofire.request(url , method: .get, parameters : nil, encoding: URLEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let value):
                        completionHandler(value as AnyObject?, nil)
                    break

                case .failure(_):
                    completionHandler(nil, response.error as NSError?)
                    break
                    
                    
                }
            }
            
        }
    }
    
    
   
    
    
    
    
}
