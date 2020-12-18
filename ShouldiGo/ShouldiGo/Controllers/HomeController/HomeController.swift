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
    
    @IBOutlet var homeCollectionView: UICollectionView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    
    
    // MARK: - Properties
    var yelpFetcher = YelpFetcher()
    var wheatherFetcher = WheatherFetcher()
    let homeCollectionDataSource = HomeCollectionDataSource()
    let homeCollectionDelegate = HomeCollectionDelegate()
    let categoryCollectionDataSource = CategoryCollectionDataSource()
    let categoryCollectionDelegate = CategoryCollectionDelegate()

    let modifiyViews = modifyLayersFunctions()

    override var prefersStatusBarHidden: Bool {
         return true
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Delegation
        homeCollectionView.delegate = homeCollectionDelegate
        homeCollectionView.dataSource = homeCollectionDataSource
        categoryCollectionView.dataSource = categoryCollectionDataSource
        categoryCollectionView.delegate = categoryCollectionDelegate
        

//        backgroundImageView.image = UIImage(named: "foodWallpaper1")
//        modifiyViews.modifyViewLayer(image: &backgroundImageView)
        
        let wheatherUrl = getWheatherURL(lon: -122.399972, lat: 37.786882, days: 3)
        let yelpUrl = getYelpURL(lat: 37.786882, lon: -122.399972, category: "resturant")

        print("Weather URL: \(wheatherUrl)")
        wheatherFetcher.fetchWheatherResults(url: wheatherUrl) { (current, error) in
            print("GEgeGe:  \(current!.current.condition.icon)")
        }
        
        print("yelp URL: \(yelpUrl)")
        yelpFetcher.fetchYelpResults(url: yelpUrl) { (result, error) in
            self.homeCollectionDataSource.yelpData = result!.businesses
            DispatchQueue.main.async {
                self.homeCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
        
    }

    
    
}
