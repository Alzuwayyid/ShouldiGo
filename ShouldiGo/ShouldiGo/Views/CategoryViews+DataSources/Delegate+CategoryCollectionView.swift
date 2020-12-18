//
//  Delegate+CategoryCollectionView.swift
//  ShouldiGo
//
//  Created by Mohammed on 18/12/2020.
//

import UIKit

class CategoryCollectionDelegate: NSObject, UICollectionViewDelegate{
    let tags = ["Food","Bars","Resturants","Cafee","Bakery","Grocery"]
    var yelpFetcher = YelpFetcher()

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Did select: \(indexPath.row)")
        let yelpUrl = getYelpURL(lat: 37.786882, lon: -122.399972, category: "bars")

        
    }
}
