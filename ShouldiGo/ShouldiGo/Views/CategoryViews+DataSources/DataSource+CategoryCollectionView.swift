//
//  DataSource+CategoryCollectionView.swift
//  ShouldiGo
//
//  Created by Mohammed on 18/12/2020.
//

import UIKit

class CategoryCollectionDataSource: NSObject, UICollectionViewDataSource{
        
    var yelpData = [Business]()
    var yelpFetcher = YelpFetcher()
    var wheatherFetcher = WheatherFetcher()
    let colorsArr = ["LightBlue", "LightRed", "MiskDarkBlue", "MiskPurple"]

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "CategoryCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        cell.contentView.layer.backgroundColor = UIColor(named: colorsArr.randomElement()!)?.cgColor
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
