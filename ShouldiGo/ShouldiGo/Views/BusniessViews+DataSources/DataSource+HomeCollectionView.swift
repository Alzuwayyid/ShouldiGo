//
//  DataSource+HomeCollectionView.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit
import Alamofire
import Kingfisher

class HomeCollectionDataSource: NSObject ,UICollectionViewDataSource{
    
    // MARK: - Properties
    var yelpData = [Business]()
    var yelpFetcher = YelpFetcher()
    var wheatherFetcher = WheatherFetcher()
    var dataStore =  DataStore()
    var isConnetedToWifi = false
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yelpData.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "homeCell"
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        animateWithBorders(&cell)

        if isConnetedToWifi{
            return configureCellIfConnected(cell, indexPath: indexPath)
        }
        else{
            return configureCellIfNOTConnected(cell, indexPath: indexPath)
        }
    }
}

// MARK: - Methods
extension HomeCollectionDataSource{
    // MARK: - Passing cells
    // If the device is not connected to Wifi, data will be loaded from the Disk
    func configureCellIfConnected(_ Passedcell: HomeCollectionViewCell, indexPath: IndexPath)->UICollectionViewCell{
        let yelpResultById = getBusinessIdURL(id: yelpData[indexPath.row].id)
        let largePreviewImageURL = URL(string: yelpData[indexPath.row].imageURL)
        // URL for current business Longitude+Latitude
        let wheatherUrl = getWheatherURL(lon: yelpData[indexPath.row].coordinates.longitude, lat: yelpData[indexPath.row].coordinates.latitude, days: 3)
        
        // Place activity indicator in the imageViews
        DispatchQueue.main.async{
            Passedcell.largePreviewImage.kf.indicatorType = .activity
            Passedcell.smallLargePreviewImage.kf.indicatorType = .activity
            Passedcell.smallPreviewImage2.kf.indicatorType = .activity
        }
        // Fetch new businesses in the Backgorund queue
        DispatchQueue.global(qos:.background).async {
            self.yelpFetcher.fetchBusniessDetails(url: yelpResultById) {(response, error) in
                DispatchQueue.main.async {
                    Passedcell.largePreviewImage.kf.setImage(with: largePreviewImageURL)
                }
                // If response contain images and more than one, set them to the current small imageViews
                if let response = response?.photos{
                    if response.count > 2{
                        let smallLargePreviewImageURL = URL(string: response[1])
                        let smallPreviewImage2URL = URL(string: response[2])
                        DispatchQueue.main.async {
                            Passedcell.smallLargePreviewImage.kf.setImage(with: smallLargePreviewImageURL)
                            Passedcell.smallPreviewImage2.kf.setImage(with: smallPreviewImage2URL)
                        }
                    }
                }
            }
        }
        
        // Download wheather status image
        wheatherFetcher.fetchWheatherResults(url: wheatherUrl) { (results, error) in
            DispatchQueue.main.async { [self] in
                Passedcell.temperatureNum.text = "\(String((results?.current.tempC)!))c"
                Passedcell.temperatureImage.kf.setImage(with: URL(string: getWheatherImageURL(imageURL: (results?.current.condition.icon)!)))
            }
        }
        Passedcell.titleOfBusiness.text = yelpData[indexPath.row].name
        Passedcell.ratingNumber.text = "\(yelpData[indexPath.row].rating)"
        Passedcell.numberOfReviews.text = "\(yelpData[indexPath.row].reviewCount) reviews"
        
        return Passedcell
    }
    
    func configureCellIfNOTConnected(_ Passedcell: HomeCollectionViewCell, indexPath: IndexPath)->UICollectionViewCell{
        let cell = Passedcell
        let largePreviewImageURL = URL(string: yelpData[indexPath.row].imageURL)
        
        DispatchQueue.main.async {
            cell.largePreviewImage.kf.indicatorType = .activity
        }
        cell.largePreviewImage.kf.setImage(with: largePreviewImageURL)
        cell.titleOfBusiness.text = yelpData[indexPath.row].name
        cell.ratingNumber.text = "\(yelpData[indexPath.row].rating)"
        cell.numberOfReviews.text = "\(yelpData[indexPath.row].reviewCount) reviews"
        
        return cell
    }
    
    func animateWithBorders(_ cell: inout HomeCollectionViewCell){
        // Animation with borderWidth
        let layer = cell.layer
        let animetion = CABasicAnimation(keyPath: #keyPath(CALayer.borderWidth))
        animetion.fromValue = NSNumber(50)
        animetion.toValue = -50
        animetion.duration = 0.90
        layer.add(animetion, forKey: "disappear")
    }
}
