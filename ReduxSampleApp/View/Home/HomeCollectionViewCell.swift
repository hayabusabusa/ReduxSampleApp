//
//  HomeCollectionViewCell.swift
//  ReduxSampleApp
//
//  Created by Yamada Shunya on 2019/05/29.
//  Copyright © 2019 山田隼也. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    
    static var nib: UINib {
        return UINib(nibName: "HomeCollectionViewCell", bundle: nil)
    }
    
    static let cellReuseIdentifier = "HomeCollectionViewCell"

    @IBOutlet weak var colorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupCell(color: ColorEntity) {
        colorView.backgroundColor = UIColor(hex: color.hex.value)
    }
}
