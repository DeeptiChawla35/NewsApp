//
//  DashboardVM.swift
//  Assignment
//
//  Created by Deepti Chawla on 28/09/21.
//

import Foundation

import KRProgressHUD
class DashboardVM  {
    
    var randomNewsDataArray = [NewsModel]()
    func callingNewsAPI(apiName:String ,completion:@escaping (_ randomNewsResponse: [NewsModel]) -> Void){
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                KRProgressHUD.show()
                ServiceHelper.sharedInstanceHelper.createPostRequest(method: .post, showHud: true, params: nil, apiName: kConstant.constants.kNewsApi) { [self] (result, error) in
                    if result != nil{
                        KRProgressHUD.dismiss()
                        let articlesData = result![kConstant.constants.kArticles] as! [[String:Any]]
                        
                        let obj = NewsModel()
                        self.randomNewsDataArray = obj.getRandomNewsResponse(dataArray: articlesData)
                        if randomNewsDataArray.count>0{
                            completion(randomNewsDataArray)
                        }
                    }else{
                    }
                }
            }
        }
    }
    
    
}
