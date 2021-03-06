//
//  DataSource+DetailsCollectionView.swift
//  ShouldiGo
//
//  Created by Mohammed on 20/12/2020.
//

import UIKit
import Kingfisher

class DaysDetailsCollectionViewDataSourceAndDelegate: NSObject,UICollectionViewDataSource ,UICollectionViewDelegate{
    
    // MARK: - Properties
    var wheatherFetcher = WheatherFetcher()
    var details = [ForecastHour]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return details.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "detailsCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DetailedDaysCollectionViewCell
        let whatherImageURL = URL(string: getWheatherImageURL(imageURL: (details[indexPath.row].condition.icon)))

        cell.tempeNum.text = "\(details[indexPath.row].tempC)c"
        cell.timeLabel.text = "\(details[indexPath.row].time.suffix(5))"
        cell.conditionImage.kf.setImage(with: whatherImageURL)

        return cell
    }
}
