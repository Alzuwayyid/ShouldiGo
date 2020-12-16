//
//  DataSource+HomeCollectionView.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit
import Alamofire

class HomeCollectionDataSource: NSObject ,UICollectionViewDataSource{
    
    #warning("Change it later")
    var yelpData = [Business]()
//    var wheatherData = [Current]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yelpData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "homeCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        
        cell.titleOfBusiness.text = yelpData[indexPath.row].name
        AF.request(URL(string: yelpData[indexPath.row].imageURL)!,method: .get).response{
            (response) in
            switch response.result {
                case .success(let photoData):
                    cell.largePreviewImage.image = UIImage(data: photoData!, scale: 1)
                    cell.smallPreviewImage2.image = UIImage(data: photoData!, scale: 1)
                    cell.smallLargePreviewImage.image = UIImage(data: photoData!, scale: 1)
                    cell.temperatureImage.image = UIImage(data: photoData!, scale: 1)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
        cell.temperatureNum.text = "14c"
        cell.ratingNumber.text = "\(yelpData[indexPath.row].rating)"
        cell.numberOfReviews.text = "\(yelpData[indexPath.row].reviewCount) review"
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    
}
