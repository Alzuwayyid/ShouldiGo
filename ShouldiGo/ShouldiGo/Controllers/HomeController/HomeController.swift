//
//  HomeController.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit
import Alamofire

class HomeController: UIViewController{
    
    // MARK: - Outlets
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var homeCollectionView: UICollectionView!
    
    
    // MARK: - Properties
    var yelpFetcher = YelpFetcher()
    var wheatherFetcher = WheatherFetcher()
    let collectionDataSource = HomeCollectionDataSource()
    let collectionDelegate = HomeCollectionDelegate()
    let modifiyViews = modifyLayersFunctions()
    override var prefersStatusBarHidden: Bool {
         return true
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Delegation
        homeCollectionView.delegate = collectionDelegate
        homeCollectionView.dataSource = collectionDataSource
        
        backgroundImageView.image = UIImage(named: "foodWallpaper1")
        modifiyViews.modifyViewLayer(image: &backgroundImageView)
        
        let wheatherUrl = getWheatherURL(lon: -122.399972, lat: 37.786882, days: 3)
        let yelpUrl = getYelpURL(lat: 37.786882, lon: -122.399972, category: "resturant")
        
        wheatherFetcher.fetchWheatherResults(url: wheatherUrl) { (results, error) in
            print("GoGe: \((results?.current.tempC)!)")
        }
        
        print("Weather URL: \(wheatherUrl)")
        wheatherFetcher.fetchWheatherResults(url: wheatherUrl) { (current, error) in
            print("GEgeGe:  \(current!.current.tempC)")
        }
        
        
        yelpFetcher.fetchYelpResults(url: yelpUrl) { (result, error) in            
            self.collectionDataSource.yelpData = result!.businesses
            DispatchQueue.main.async {
                self.homeCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }

    
    
}
