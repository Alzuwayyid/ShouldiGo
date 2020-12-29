//
//  Extensions+HomeController.swift
//  ShouldiGo
//
//  Created by Mohammed on 19/12/2020.
//

import UIKit
import Alamofire

// MARK: - SearchBar delegate
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
            // Fetching and updating autocompleted results in the tableView
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

// MARK: - Category collectionView delegate
extension HomeController: UICollectionViewDelegate{
    
    // Update HomeCollectionView based on selected category
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            categoryCollectionDataSourceAndDelegate.tagsCounter = indexPath.row
        }
        
        // MARK: - Check internt connectivity
        let networkManager = NetworkReachabilityManager()
        let yelpUrl = getBusinessByLocation(location: self.currentLocation, category: "\(tags[indexPath.row])")
        
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

// MARK: - preapre for segue extension
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
                    decVC.latitude = latitude!
                    decVC.longitude = longitude!
                    decVC.phoneNumberText = phoneNumber
                    decVC.titleText = busTitle
                    decVC.addressText = address!
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
