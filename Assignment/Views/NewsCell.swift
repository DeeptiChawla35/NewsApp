//
//  NewsCell.swift
//  Assignment
//
//  Created by Deepti Chawla on 28/09/21.
//

import UIKit

class NewsCell: UICollectionViewCell {
    var likeCount = 0
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
}
