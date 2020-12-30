//
//  HomeController.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit
import Alamofire
import Lottie

class HomeController: UIViewController{
    
    // MARK: - Outlets
    @IBOutlet var homeCollectionView: UICollectionView!
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchResultsTableView: UITableView!
    
    // MARK: - Properties
    private var animationView: AnimationView?
    private var noWifiView: AnimationView?
    let homeCollectionDataSource = HomeCollectionDataSource()
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

        // MARK: - Properities configuration
        animationView = .init(name: "purpleLoadingLottie")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
        animationView!.play()
        noWifiView = .init(name: "noWifi")
        noWifiView!.frame = CGRect(x: 150, y: 30, width: 80, height: 80)
        noWifiView!.contentMode = .scaleAspectFit
        noWifiView!.loopMode = .loop
        noWifiView!.animationSpeed = 0.5
        searchResultsTableView.isHidden = true

        if currentCategory == ""{
            currentCategory = "Bakeries"
        }
        if currentLocation == ""{
            currentLocation = "NYC"
        }
        
        // Build Yelp URL
        let yelpUrl = getBusinessByLocation(location: currentLocation, category: currentCategory)

        // MARK: - Check internt connectivity
        let networkManager = NetworkReachabilityManager()

        // If Wifi is off, load data from the disk
        networkManager?.startListening(onUpdatePerforming: { (status) in
            switch status{
                case .unknown:
                    print("-Unknown")
                case .notReachable:
                    self.view.addSubview(self.noWifiView!)
                    self.noWifiView!.play()
                    self.searchBar.isHidden = true
                    self.homeCollectionDataSource.isConnetedToWifi = false
                    self.dataStore.loadYelpData { (result) in
                        self.homeCollectionDataSource.yelpData = result
                        DispatchQueue.main.async {
                            self.animationView!.stop()
                            self.animationView!.isHidden = true
                            self.homeCollectionView.reloadSections(IndexSet(integer: 0))
                        }
                  }
                    print("HomeController: Not reachable")
                case .reachable(_):
                    self.homeCollectionDataSource.isConnetedToWifi = true
                    self.yelpFetcher.fetchYelpResults(url: yelpUrl) { (result, error) in
                        if let result = result{
                            if let resultBusiness = result.businesses{
                                self.homeCollectionDataSource.yelpData = resultBusiness
                                self.yelpData = resultBusiness
                                self.dataStore.yelpBusinessData = resultBusiness
                            }
                            self.dataStore.saveChangesToYelp()
                        }
                        DispatchQueue.main.async {
                            self.animationView!.stop()
                            self.animationView!.isHidden = true
                            self.homeCollectionView.reloadSections(IndexSet(integer: 0))
                        }
                    }
                    print("HomeController: reachable")
            }
        })
    }
}



