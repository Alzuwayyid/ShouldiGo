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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "homeCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        

        // Animation with borderWidth
        let layer = cell.layer
        let animetion = CABasicAnimation(keyPath: #keyPath(CALayer.borderWidth))
        animetion.fromValue = NSNumber(50)
        animetion.toValue = -50
        animetion.duration = 0.90

        layer.add(animetion, forKey: "disappear")
        

        if isConnetedToWifi{
            return configureCellIfConnected(cell, indexPath: indexPath)
        }
        else{
            return configureCellIfNOTConnected(cell, indexPath: indexPath)
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func configureCellIfConnected(_ Passedcell: HomeCollectionViewCell, indexPath: IndexPath)->UICollectionViewCell{
        let largePreviewImageURL = URL(string: yelpData[indexPath.row].imageURL)
        DispatchQueue.main.async{
            Passedcell.largePreviewImage.kf.indicatorType = .activity
            Passedcell.smallLargePreviewImage.kf.indicatorType = .activity
            Passedcell.smallPreviewImage2.kf.indicatorType = .activity
            
            DispatchQueue.main.async(group: .none, qos: .background, flags: .assignCurrentContext) { [self] in
                let yelpResultById = getBusinessIdURL(id: yelpData[indexPath.row].id)
                yelpFetcher.fetchBusniessDetails(url: yelpResultById) {(response, error) in
                    Passedcell.largePreviewImage.kf.setImage(with: largePreviewImageURL)
                    if let response = response?.photos{
                        let smallLargePreviewImageURL = URL(string: response[0])
                        let smallPreviewImage2URL = URL(string: response[1])
                        DispatchQueue.main.async {
                            Passedcell.smallLargePreviewImage.kf.setImage(with: smallLargePreviewImageURL)
                            Passedcell.smallPreviewImage2.kf.setImage(with: smallPreviewImage2URL)
                        }
                    }
                }
            }
        }
        let wheatherUrl = getWheatherURL(lon: yelpData[indexPath.row].coordinates.longitude, lat: yelpData[indexPath.row].coordinates.latitude, days: 7)
        
        // Download wheather status image
            wheatherFetcher.fetchWheatherResults(url: wheatherUrl) { (results, error) in
                DispatchQueue.main.async { [self] in
                    Passedcell.temperatureNum.text = "\(String((results?.current.tempC)!))c"
                    Passedcell.temperatureImage.setImageFromURL(url: getWheatherImageURL(imageURL: (results?.current.condition.icon)!))
                }
            }
        
        Passedcell.titleOfBusiness.text = yelpData[indexPath.row].name
        Passedcell.ratingNumber.text = "\(yelpData[indexPath.row].rating)"
        Passedcell.numberOfReviews.text = "\(yelpData[indexPath.row].reviewCount) reviews"
        
        print("test yelp array: \(dataStore.yelpBusinessData)")
        
        return Passedcell
    }
    
    
    
    func configureCellIfNOTConnected(_ Passedcell: HomeCollectionViewCell, indexPath: IndexPath)->UICollectionViewCell{
        let cell = Passedcell
        
        let largePreviewImageURL = URL(string: yelpData[indexPath.row].imageURL)
            cell.largePreviewImage.kf.indicatorType = .activity
            cell.largePreviewImage.kf.setImage(with: largePreviewImageURL)
        
        cell.titleOfBusiness.text = yelpData[indexPath.row].name
        cell.ratingNumber.text = "\(yelpData[indexPath.row].rating)"
        cell.numberOfReviews.text = "\(yelpData[indexPath.row].reviewCount) reviews"

        return cell
    }
    
}


