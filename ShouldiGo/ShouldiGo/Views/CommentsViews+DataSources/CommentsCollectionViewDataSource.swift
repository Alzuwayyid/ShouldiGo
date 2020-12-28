//
//  CommentsCollectionViewDataSource.swift
//  ShouldiGo
//
//  Created by Mohammed on 21/12/2020.
//

import UIKit
import Kingfisher

class CommentsCollectionView: NSObject, UICollectionViewDataSource{
    var reviewsData = [Review]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reviewsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "reviewsCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentsCollectionViewCell
        
        cell.userName.text = reviewsData[indexPath.row].user?.name
        cell.commentTextView.text = reviewsData[indexPath.row].text
        cell.userLogo.kf.setImage(with: reviewsData[indexPath.row].user?.imageURL)
        
        return cell
    }
    
    
}
