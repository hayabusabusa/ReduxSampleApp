//
//  HomeCollectionViewCell.swift
//  ReduxSampleApp
//
//  Created by Yamada Shunya on 2019/05/29.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import UIKit
import Hero

class HomeCollectionViewCell: UICollectionViewCell {
    
    static var nib: UINib {
        return UINib(nibName: "HomeCollectionViewCell", bundle: nil)
    }
    
    static let cellReuseIdentifier = "HomeCollectionViewCell"

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(color: ColorEntity) {
        colorView.backgroundColor = UIColor(hex: color.hex.clean)
        favoriteImageView.isHidden = !color.isFavorite
    }
}
