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
    let categoryCollectionDataSourceAndDelegate = CategoryCollectionDataSource()
    let modifiyViews = modifyLayersFunctions()
    let tags = ["Bakeries","Bars","Resturant","Cafee","Autorepair","Grocery"]


    override var prefersStatusBarHidden: Bool {
         return true
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Delegation
        homeCollectionView.delegate = homeCollectionDelegate
        homeCollectionView.dataSource = homeCollectionDataSource
        categoryCollectionView.dataSource = categoryCollectionDataSourceAndDelegate
        categoryCollectionView.delegate = self

        
        let wheatherUrl = getWheatherURL(lon: -122.399972, lat: 37.786882, days: 3)
        let yelpUrl = getYelpURL(lat: 37.786882, lon: -122.399972, category: "Bakeries")

        wheatherFetcher.fetchWheatherResults(url: wheatherUrl) { (current, error) in
        }
        
        yelpFetcher.fetchYelpResults(url: yelpUrl) { (result, error) in
            self.homeCollectionDataSource.yelpData = result!.businesses
            DispatchQueue.main.async {
                self.homeCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
        
    }
}


extension HomeController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            categoryCollectionDataSourceAndDelegate.tagsCounter = indexPath.row
        }
        
        let yelpUrl = getYelpURL(lat: 37.786882, lon: -122.399972, category: "\(tags[indexPath.row])")
        yelpFetcher.fetchYelpResults(url: yelpUrl) { (result, error) in
            self.homeCollectionDataSource.yelpData = result!.businesses
            DispatchQueue.main.async {
                self.homeCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }

    }
}
