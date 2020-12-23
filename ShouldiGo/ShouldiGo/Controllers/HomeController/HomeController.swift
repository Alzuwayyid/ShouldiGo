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
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchResultsTableView: UITableView!
    
    // MARK: - Properties
    let homeCollectionDataSource = HomeCollectionDataSource()
    let homeCollectionDelegate = HomeCollectionDelegate()
    let categoryCollectionDataSourceAndDelegate = CategoryCollectionDataSource()
    let modifiyViews = modifyLayersFunctions()
    let tags = ["Bakeries","Mall","Resturant","Cafee","Autorepair","Grocery"]
    let sectionsName = ["Categories", "Locations"]
    var yelpFetcher = YelpFetcher()
    var wheatherFetcher = WheatherFetcher()
    var dataStore =  DataStore()
    var yelpData = [Business]()
    var autoCompleteArr = [Term]()
    var autoCompleteRegion = [CountryAutoCompletionResult]()
    var currentCategory = ""
    var currentLocation = ""
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Delegation
        homeCollectionView.dataSource = homeCollectionDataSource
        categoryCollectionView.dataSource = categoryCollectionDataSourceAndDelegate
        categoryCollectionView.delegate = self
        searchBar.delegate = self
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        
        searchResultsTableView.isHidden = true

        // Build Yelp URL
        if currentCategory == ""{
            currentCategory = "Bakeries"
        }
        if currentLocation == ""{
            currentLocation = "NYC"
        }
        
        let yelpUrl = getBusinessByLocation(location: currentLocation, category: currentCategory)

        // MARK: - Check internt connectivity
        let networkManager = NetworkReachabilityManager()

        networkManager?.startListening(onUpdatePerforming: { (status) in
            switch status{
                case .unknown:
                    print("-Unknown")
                case .notReachable:
                    self.homeCollectionDataSource.isConnetedToWifi = false
                    self.dataStore.loadYelpData { (result) in
                        self.homeCollectionDataSource.yelpData = result
                        DispatchQueue.main.async {
                            self.homeCollectionView.reloadSections(IndexSet(integer: 0))
                        }
                    }
                    
                    print("Not reachable")
                case .reachable(_):
                    self.homeCollectionDataSource.isConnetedToWifi = true
                    self.yelpFetcher.fetchYelpResults(url: yelpUrl) { (result, error) in
                        if let result = result{
                            self.homeCollectionDataSource.yelpData = result.businesses!
                            self.yelpData = result.businesses!
                            self.dataStore.yelpBusinessData = result.businesses!
                            self.dataStore.saveChanges()
                        }
                        DispatchQueue.main.async {
                            self.homeCollectionView.reloadSections(IndexSet(integer: 0))
                        }

                    }
                    print("reachable")
            }
        })
                
    }
}



