//
//  DetailScreenVC.swift
//  Assignment
//
//  Created by Deepti Chawla on 28/09/21.
//

import UIKit
import SDWebImage
class DetailScreenVC: UIViewController {
    
    @IBOutlet weak var newsName: UILabel!
    @IBOutlet weak var newsPublished: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsAuthor: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    var newsModelData = NewsModel()
    override func viewDidLoad() {
        super.viewDidLoad()
          setInitialData()
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    func setInitialData(){
        
        if newsModelData.name != kConstant.constants.kBlank{
            newsName.text =  newsModelData.name
        }
       
        if newsModelData.title != kConstant.constants.kBlank{
            newsTitle.text =  newsModelData.title
        }
        if newsModelData.author != kConstant.constants.kBlank{
            newsAuthor.text = kConstant.constants.kAuthorat + newsModelData.author
        }
        if newsModelData.publishedAt != kConstant.constants.kBlank{
            newsPublished.text = kConstant.constants.kPublished + newsModelData.publishedAt
        }
        
        if newsModelData.descript != kConstant.constants.kBlank{
            newsDescription.text = newsModelData.descript
        }
        
        if newsModelData.urlToImage != kConstant.constants.kBlank{
            newsImageView.sd_setImage(with: URL(string: newsModelData.urlToImage), placeholderImage: UIImage(named: kConstant.constants.kDefaultImage))
        }
      
        
    }


}
