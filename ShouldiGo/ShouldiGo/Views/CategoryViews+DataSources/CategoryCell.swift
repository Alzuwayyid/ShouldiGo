//
//  CategoryCell.swift
//  ShouldiGo
//
//  Created by Mohammed on 18/12/2020.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell{
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.layer.cornerRadius = 7
        let margins = UIEdgeInsets(top: 0, left: 0.5, bottom: 0, right: 0.5)
        contentView.frame = contentView.frame.inset(by: margins)
        contentView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.3
        contentView.tintColor = .white

    }
}
