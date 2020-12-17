//
//  HomeCellCard.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell{
    // MARK: - IBOutlets
    // images
    @IBOutlet var largePreviewImage: UIImageView!
    @IBOutlet var smallLargePreviewImage: UIImageView!
    @IBOutlet var smallPreviewImage2: UIImageView!
    @IBOutlet var temperatureImage: UIImageView!
    // labels
    @IBOutlet var titleOfBusiness: UILabel!
    @IBOutlet var ratingNumber: UILabel!
    @IBOutlet var numberOfReviews: UILabel!
    @IBOutlet var temperatureNum: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 15

        let margins = UIEdgeInsets(top: 5, left: 0.5, bottom: 5, right: 0.5)

        contentView.frame = contentView.frame.inset(by: margins)
//        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.3
        contentView.tintColor = .white
        
        #warning("Cell background color")
        contentView.layer.backgroundColor = .init(gray: 1, alpha: 0.11)
        self.backgroundColor = .clear

    }
}
