//
//  CommentsCollectionViewCell.swift
//  ShouldiGo
//
//  Created by Mohammed on 21/12/2020.
//

import UIKit

class CommentsCollectionViewCell: UICollectionViewCell {
    @IBOutlet var userLogo: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var commentTextView: UITextView!
        
    
    override func layoutSubviews() {
        super.layoutSubviews()

        
        userLogo.layer.cornerRadius = userLogo.frame.height/2
        userLogo.layer.masksToBounds = true

    }
}
