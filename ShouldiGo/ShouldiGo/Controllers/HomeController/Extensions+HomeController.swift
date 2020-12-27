//
//  Extensions+HomeController.swift
//  ShouldiGo
//
//  Created by Mohammed on 19/12/2020.
//

import UIKit
import Alamofire

extension HomeController: UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchResultsTableView.isHidden = false
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        searchResultsTableView.isHidden = true
        
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let cancelButton : UIButton = searchBar.value(forKey: "cancelButton") as? UIButton{
            cancelButton.isEnabled = true
        }
        searchResultsTableView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchResultsTableView.isHidden = false
        print("textChanged: \(searchText)")
        // Start auto completing the text when user types more than three words to mimimize requests
        if searchText.count > 3{
            let autoCompleteURL = getAutoCompleteURL(text: searchText.replacingOccurrences(of: " ", with: "-", options: .regularExpression, range: nil))
            let regionAutoComleteURL = getAutoCompleteURL(locationName: searchText.replacingOccurrences(of: " ", with: "-", options: .regularExpression, range: nil))
            self.wheatherFetcher.fetchAutoCompletedResults(url: regionAutoComleteURL) { (result, error) in
                self.autoCompleteRegion = result!
                DispatchQueue.main.async {
                    self.searchResultsTableView.reloadSections(IndexSet(integer: 1), with: .right)
                }
            }
            
            DispatchQueue.main.async { [self] in
                yelpFetcher.fetchAutoCompleteResults(url: autoCompleteURL) { (result, error) in
                    self.autoCompleteArr = result!.terms
                    DispatchQueue.main.async {
                        self.searchResultsTableView.reloadSections(IndexSet(integer: 0), with: .right)
                    }
                }
            }
        }
    }
    
}

// Category collection delegate
extension HomeController: UICollectionViewDelegate{
    
    // Update HomeCollectionView based on selected category
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            categoryCollectionDataSourceAndDelegate.tagsCounter = indexPath.row
        }
        
        let yelpUrl = getBusinessByLocation(location: self.currentLocation, category: "\(tags[indexPath.row])")
        
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
                            self.dataStore.saveChangesToYelp()
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

extension HomeController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
            case "toDetails":
                if let selectedIndexPath = homeCollectionView.indexPathsForSelectedItems!.first{
                    let busTitle = homeCollectionDataSource.yelpData[selectedIndexPath.row].name
                    let address = homeCollectionDataSource.yelpData[selectedIndexPath.row].location!.address1
                    let ratingNumber = homeCollectionDataSource.yelpData[selectedIndexPath.row].rating
                    let largeImge = homeCollectionDataSource.yelpData[selectedIndexPath.row].imageURL
                    let phoneNumber = homeCollectionDataSource.yelpData[selectedIndexPath.row].phone
                    let category = homeCollectionDataSource.yelpData[selectedIndexPath.row].categories[0].title
                    let busniessID = homeCollectionDataSource.yelpData[selectedIndexPath.row].id
                    let latitude = homeCollectionDataSource.yelpData[selectedIndexPath.row].coordinates.latitude
                    let longitude = homeCollectionDataSource.yelpData[selectedIndexPath.row].coordinates.longitude
                    
                    let decVC = segue.destination as! DetailedViewController
                    decVC.latitude = latitude
                    decVC.longitude = longitude
                    decVC.phoneNumberText = phoneNumber
                    decVC.titleText = busTitle
                    decVC.addressText = address
                    decVC.ratingText = "\(ratingNumber)"
                    decVC.largeImageURL = largeImge
                    decVC.categoryText = category
                    decVC.busID = busniessID
                }
            default:
                print("Could not prefrom segue")
        }
    }
}


// MARK: - SearchBar tableView
extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsName[section]
    }
    
    // Section 0 is the categories while 1 is the location
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            guard autoCompleteArr.count > 0 else{
                return 0
            }
            return autoCompleteArr.count
        }
        if section == 1{
            guard autoCompleteRegion.count > 0 else{
                return 0
            }
            return autoCompleteRegion.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = "searchTable"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if indexPath.section == 0{
            cell.textLabel?.text = "\(autoCompleteArr[indexPath.row].text)"
        }
        if indexPath.section == 1{
            cell.textLabel?.text = "\(autoCompleteRegion[indexPath.row].name)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // MARK: - Check internt connectivity
        let networkManager = NetworkReachabilityManager()
        
        // Fetch data for categories and location
        networkManager?.startListening(onUpdatePerforming: { (status) in
            switch status{
                case .unknown:
                    print("-Unknown")
                case .notReachable:
                    if indexPath.section == 0{
                        if self.autoCompleteArr.count > 0{
                            self.homeCollectionDataSource.isConnetedToWifi = false
                            self.dataStore.loadYelpData { (result) in
                                self.homeCollectionDataSource.yelpData = result
                                DispatchQueue.main.async {
                                    self.homeCollectionView.reloadSections(IndexSet(integer: 0))
                                }
                            }
                            self.searchResultsTableView.isHidden = true
                        }
                    }
                    if indexPath.section == 1{
                        if self.autoCompleteRegion.count > 0{
                            self.homeCollectionDataSource.isConnetedToWifi = false
                            self.dataStore.loadYelpData { (result) in
                                DispatchQueue.main.async {
                                    self.homeCollectionDataSource.yelpData = result
                                    self.homeCollectionView.reloadSections(IndexSet(integer: 0))
                                }
                            }
                            
                        }
                    }
                    print("Not reachable")
                case .reachable(_):
                    if indexPath.section == 0{
                        if self.autoCompleteArr.count > 0{
                            self.currentCategory = self.autoCompleteArr[indexPath.row].text.replacingOccurrences(of: " ", with: "-", options: .regularExpression, range: nil)
                            let yelpUrl = getBusinessByLocation(location: self.currentLocation, category: self.currentCategory)
                            self.homeCollectionDataSource.isConnetedToWifi = true
                            self.yelpFetcher.fetchYelpResults(url: yelpUrl) { (result, error) in
                                if let result = result{
                                    self.homeCollectionDataSource.yelpData = result.businesses!
                                    self.yelpData = result.businesses!
                                    self.dataStore.yelpBusinessData = result.businesses!
                                    self.dataStore.saveChangesToYelp()
                                }
                                DispatchQueue.main.async {
                                    self.homeCollectionView.reloadSections(IndexSet(integer: 0))
                                }
                                
                            }
                        }
                        
                        self.searchResultsTableView.isHidden = true
                    }
                    if indexPath.section == 1{
                        if self.autoCompleteRegion.count > 0{
                            self.currentLocation = self.autoCompleteRegion[indexPath.row].name.replacingOccurrences(of: " ", with: "-", options: .regularExpression, range: nil).replacingOccurrences(of: ",", with: "-", options: .regularExpression, range: nil)
                            let yelpUrl = getBusinessByLocation(location: self.currentLocation, category: self.currentCategory)
                            self.homeCollectionDataSource.isConnetedToWifi = true
                            self.yelpFetcher.fetchYelpResults(url: yelpUrl) { (result, error) in
                                if let result = result{
                                    self.homeCollectionDataSource.yelpData = result.businesses!
                                    self.yelpData = result.businesses!
                                    self.dataStore.yelpBusinessData = result.businesses!
                                    self.dataStore.saveChangesToYelp()
                                }
                                DispatchQueue.main.async {
                                    self.homeCollectionView.reloadSections(IndexSet(integer: 0))
                                }
                                
                            }
                            self.searchResultsTableView.isHidden = true
                        }
                    }
                    
                    print("reachable")
            }
        })
    }
}
