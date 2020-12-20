//
//  DataSource+DetailsCollectionView.swift
//  ShouldiGo
//
//  Created by Mohammed on 20/12/2020.
//

import UIKit

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
        
        cell.backgroundColor = .systemRed
        
        // Hour[] gives detailed info about the day
        cell.tempeNum.text = "\(details[indexPath.row].tempC)c"
        cell.timeLabel.text = "\(details[indexPath.row].time.suffix(5))"
        cell.conditionImage.setImageFromURL(url: getWheatherImageURL(imageURL: (details[indexPath.row].condition.icon)))
                
        return cell
    }
}

//func militaryTimeToAmPm(text: String)->String{
//    let hour = Double(text.prefix(2))
//    if hour! >= 00 && hour! <= 11{
//        return "\(hour!)" + text.suffix(2) + "AM"
//    }
//    
//    return String(hour!)
//}
