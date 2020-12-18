//
//  DataSource+CategoryCollectionView.swift
//  ShouldiGo
//
//  Created by Mohammed on 18/12/2020.
//

import UIKit

class CategoryCollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var yelpData = [Business]()
    var yelpFetcher = YelpFetcher()
    var wheatherFetcher = WheatherFetcher()
    let colorsArr = ["LightBlue", "LightRed", "MiskDarkBlue", "MiskPurple"]
    let tags = ["Bakeries","Bars","Resturant","Cafee","Autorepair","Grocery"]
    var tagsCounter = 0
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "CategoryCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        cell.contentView.layer.backgroundColor = UIColor(named: colorsArr.randomElement()!)?.cgColor
        print("bregbrw: \(tagsCounter)")
        cell.categoryTags.text = tags[indexPath.row]

        
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}
