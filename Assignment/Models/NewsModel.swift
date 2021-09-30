//
//  NewsModel.swift
//  Assignment
//
//  Created by Deepti Chawla on 28/09/21.
//

import Foundation

public class NewsModel: NSObject {
    
    var author = String()
    var urlToImage = String()
    var publishedAt = String()
    var url = String()
    var descript = String()
    var title = String()
    var name = String()
    var like = String()
    var dislike = String()
    public  func getRandomNewsResponse(dataArray : [[String:Any]]) -> [NewsModel] {
        var tempArray = [NewsModel]()
        
        for i in 0..<dataArray.count {
            let info = NewsModel()
            info.author = notnull(kConstant.constants.kAuthor,dataArray[i])
            
            info.urlToImage =
            notnull(kConstant.constants.kurlToImage,dataArray[i])
            info.publishedAt =
            notnull(kConstant.constants.kpublishedAt,dataArray[i])
            info.url =
            notnull(kConstant.constants.kurl,dataArray[i])
            
            info.descript =  notnull(kConstant.constants.kdescription,dataArray[i])
            info.title = notnull(kConstant.constants.kTitle,dataArray[i])
            
            
            if let sourceData = dataArray[i][kConstant.constants.kSource] as? [String:Any] {
                info.name = sourceData[kConstant.constants.kname] as? String ?? ""
                
            }
            tempArray.append(info)
        }
        return tempArray
    }
    
}
