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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yelpData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "homeCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        
        // Downlaod images and cache them using Kingfisher
        let largePreviewImageURL = URL(string: yelpData[indexPath.row].imageURL)
        DispatchQueue.main.async{
            cell.largePreviewImage.kf.indicatorType = .activity
            cell.largePreviewImage.kf.setImage(with: largePreviewImageURL)
            DispatchQueue.main.async(group: .none, qos: .background, flags: .assignCurrentContext) { [self] in
                let yelpResultById = getBusinessIdURL(id: yelpData[indexPath.row].id)
                yelpFetcher.fetchBusniessDetails(url: yelpResultById) {(response, error) in
                    
                    let smallLargePreviewImageURL = URL(string: response!.photos[1])
                    let smallPreviewImage2URL = URL(string: response!.photos[2])
                    DispatchQueue.main.async {
                        cell.smallLargePreviewImage.kf.indicatorType = .activity
                        cell.smallPreviewImage2.kf.indicatorType = .activity

                        cell.smallLargePreviewImage.kf.setImage(with: smallLargePreviewImageURL)
                        cell.smallPreviewImage2.kf.setImage(with: smallPreviewImage2URL)
                    }

                }
            }
        }
        
        let wheatherUrl = getWheatherURL(lon: yelpData[indexPath.row].coordinates.longitude, lat: yelpData[indexPath.row].coordinates.latitude, days: 7)

        // Download wheather status image
            wheatherFetcher.fetchWheatherResults(url: wheatherUrl) { (results, error) in
                DispatchQueue.main.async { [self] in
                    cell.temperatureNum.text = "\(String((results?.current.tempC)!))c"
                    cell.temperatureImage.setImageFromURL(url: getWheatherImageURL(imageURL: (results?.current.condition.icon)!))
                }
            }

        
        cell.titleOfBusiness.text = yelpData[indexPath.row].name
        cell.ratingNumber.text = "\(yelpData[indexPath.row].rating)"
        cell.numberOfReviews.text = "\(yelpData[indexPath.row].reviewCount) reviews"
        
        // Animation with borderWidth
        let layer = cell.layer
        let animetion = CABasicAnimation(keyPath: #keyPath(CALayer.borderWidth))
        animetion.fromValue = NSNumber(50)
        animetion.toValue = -50
        animetion.duration = 0.90

        layer.add(animetion, forKey: "disappear")
        
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension UIImageView {

    func setImageFromURL(url: String) {

        DispatchQueue.global().async {

            let data = NSData.init(contentsOf: NSURL.init(string: url)! as URL)
            DispatchQueue.main.async {

                let image = UIImage.init(data: data! as Data)
                self.image = image
            }
        }
    }
}
