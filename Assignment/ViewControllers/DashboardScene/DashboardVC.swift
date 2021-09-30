//
//  DashboardVC.swift
//  Assignment
//
//  Created by Deepti Chawla on 28/09/21.
//

import UIKit
import SDWebImage
import KRProgressHUD
class DashboardVC: UIViewController{
    
    private var numbeOfItemsInRow = 2
    @IBOutlet weak var collectionView: UICollectionView!
    var dashboardVM = DashboardVM()
    var randomNewsArray = [NewsModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        callingNewsAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
    }
    
    private func prepareCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: kConstant.constants.kNewsCell, bundle: nil), forCellWithReuseIdentifier: kConstant.constants.kNewsCell)
        
    }
    
    func callingNewsAPI(){
        
        if Reachability.init().isConnectedToNetwork(){
            KRProgressHUD.show()
            dashboardVM.callingNewsAPI(apiName:kConstant.constants.kNewsApi,completion: {randomNewsArray in
                self.randomNewsArray = randomNewsArray
                self.reloadCollectionView()
            })
        }else{
            ShowAlert.init().showAlert(self, message: kConstant.constants.kCheckInternetConnection)
        }
        
    }
    
    @IBAction func logoutButtonAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: kConstant.constants.kLOGIN_STATUS)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func reloadCollectionView(){
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

extension DashboardVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.randomNewsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kConstant.constants.kNewsCell, for: indexPath) as? NewsCell
        let randomNewsItem = randomNewsArray[indexPath.row]
        cell?.newsName.text = randomNewsItem.name
        cell?.newsDescription.text  = randomNewsItem.descript
        cell?.imageView.sd_setImage(with: URL(string: randomNewsItem.urlToImage), placeholderImage: UIImage(named: kConstant.constants.kDefaultImage))
        cell?.likeButton.addTarget(self, action: #selector(likeBtnAction(_:)), for: .touchUpInside)
      
        return cell!
    }
  
    @objc func likeBtnAction(_ sender: AnyObject) {
        let position: CGPoint = sender.convert(.zero, to: self.collectionView)
    
        let indexPath = self.collectionView.indexPathForItem(at: position)
        let cell: NewsCell = (collectionView.cellForItem(at: indexPath!) as? NewsCell)!
        if cell.likeButton.isSelected {
            cell.likeButton.isSelected = false
            cell.likeCount -= 1
            cell.likeCountLabel.text = "(\(cell.likeCount))"
            if #available(iOS 13.0, *) {
                cell.likeButton.setImage(UIImage(systemName: kConstant.constants.kDislikeImage), for: .normal)
            }
        }else{
            cell.likeButton.isSelected = true
            cell.likeCount += 1
            cell.likeCountLabel.text = "(\(cell.likeCount))"
            if #available(iOS 13.0, *) {
                cell.likeButton.setImage(UIImage(systemName: kConstant.constants.klikeImage), for: .normal)
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let randomNewsItem = randomNewsArray[indexPath.row]
        
        let vc = UIStoryboard.init(name: kConstant.constants.kMain, bundle: Bundle.main).instantiateViewController(withIdentifier: kConstant.constants.kDetailScreen) as? DetailScreenVC
        vc?.newsModelData =  randomNewsItem
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension DashboardVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if collectionView == self.collectionView {
            return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        } else {
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.collectionView {
            let width = (Int(UIScreen.main.bounds.size.width) - (numbeOfItemsInRow - 1) * 6 - 40) / numbeOfItemsInRow
            return CGSize(width: width, height: 225)
        } else {
            return CGSize(width: 50, height: 50)
        }
    }
}


