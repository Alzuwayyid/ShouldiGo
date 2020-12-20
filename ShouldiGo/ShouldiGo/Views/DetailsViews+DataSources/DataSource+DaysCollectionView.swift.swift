//
//  DataSource+DaysCollectionView.swift.swift
//  ShouldiGo
//
//  Created by Mohammed on 20/12/2020.
//

import UIKit

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
        
        cell.backgroundColor = .systemGray4
        cell.DayLabel.text = "\(details[indexPath.row].date)"

                
        return cell
    }
}

