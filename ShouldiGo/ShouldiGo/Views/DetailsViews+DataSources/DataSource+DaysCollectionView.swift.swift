//
//  DataSource+DaysCollectionView.swift.swift
//  ShouldiGo
//
//  Created by Mohammed on 20/12/2020.
//

import UIKit
import Kingfisher

class DaysCollectionViewDataSourceAndDelegate: NSObject,UICollectionViewDataSource, UICollectionViewDelegate{
    // MARK: - Properties
    var wheatherFetcher = WheatherFetcher()
    var details = [Forecastday]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return details.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "daysCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DaysCollectionViewCell
        
        cell.maxTemp.text = "\(details[indexPath.row].day.maxtempC)c"
        cell.minTemp.text = "\(details[indexPath.row].day.mintempC)c"
        cell.wheatherIcon.kf.setImage(with: URL(string: getWheatherImageURL(imageURL: (details[indexPath.row].day.condition.icon))))
//        cell.wheatherIcon.setImageFromURL(url: getWheatherImageURL(imageURL: (details[indexPath.row].day.condition.icon)))
        cell.DayLabel.text = "\(details[indexPath.row].date.suffix(5))"

                
        return cell
    }
}

