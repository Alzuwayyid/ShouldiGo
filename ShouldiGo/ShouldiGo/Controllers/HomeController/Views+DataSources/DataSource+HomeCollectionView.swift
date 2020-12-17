//
//  DataSource+HomeCollectionView.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit
import Alamofire

class HomeCollectionDataSource: NSObject ,UICollectionViewDataSource{
    
    var yelpData = [Business]()
    var yelpFetcher = YelpFetcher()
    
    //    var wheatherData = [Current]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yelpData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = "homeCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCollectionViewCell
        let dispatchGroup = DispatchGroup()
        
        AF.request(URL(string: yelpData[indexPath.row].imageURL)!,method: .get).response{
            (response) in
            switch response.result {
                case .success(let photoData):
                    cell.largePreviewImage.image = UIImage(data: photoData!, scale: 1)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
        
        DispatchQueue.main.async(group: .none, qos: .userInteractive, flags: .assignCurrentContext) { [self] in
            let yelpResultById = getBusinessIdURL(id: yelpData[indexPath.row].id)
            yelpFetcher.fetchBusniessDetails(url: yelpResultById) {(response, error) in
                cell.smallLargePreviewImage.setImageFromURL(url: (response?.photos[1])!)
                cell.smallPreviewImage2.setImageFromURL(url: (response?.photos[2])!)
                print("tempTemp \(response!.photos)")
            }
        }
        
        
        
        cell.titleOfBusiness.text = yelpData[indexPath.row].name
        cell.temperatureNum.text = "14c"
        cell.ratingNumber.text = "\(yelpData[indexPath.row].rating)"
        cell.numberOfReviews.text = "\(yelpData[indexPath.row].reviewCount) review"
        
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
