//
//  HomeCollectionViewCell.swift
//  SurveyClient
//
//  Created by Bryan A Bolivar M on 25/09/23.
//

import UIKit
import Core
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var model: Survey? {
        didSet {
            guard let _ = model else {
                return
            }
            reloadImage()
        }
    }
    
    func reloadImage() {
        imageView.kf.setImage(with: URL(string: model?.coverImageURL ?? ""))
        imageView.contentMode = .scaleAspectFill
    }
    
}
