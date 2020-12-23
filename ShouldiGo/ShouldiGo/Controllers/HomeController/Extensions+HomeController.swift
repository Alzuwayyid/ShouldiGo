//
//  Extensions+HomeController.swift
//  ShouldiGo
//
//  Created by Mohammed on 19/12/2020.
//

import UIKit
import Alamofire

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsName[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            guard autoCompleteArr.count > 0 else{
                return 0
            }
            return autoCompleteArr.count
        }
        else if section == 1{
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if autoCompleteArr.count > 0 {
            let yelpUrl = getYelpAutoCompletedURL(lat: 37.786882, lon: -122.399972, category: autoCompleteArr[indexPath.row].text)

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
                                self.homeCollectionDataSource.yelpData = result.businesses
                                self.yelpData = result.businesses
                                self.dataStore.yelpBusinessData = result.businesses
                                self.dataStore.saveChanges()
                            }
                            DispatchQueue.main.async {
                                self.homeCollectionView.reloadSections(IndexSet(integer: 0))
                            }

                        }
                        print("reachable")
                }
            })
            
            
            self.searchResultsTableView.isHidden = true
        }
    }
}



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
    
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            print("Yo")
            if(searchBar.text ?? "" != ""){

            }
        }
    
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchBar.resignFirstResponder()
            if let cancelButton : UIButton = searchBar.value(forKey: "cancelButton") as? UIButton{
                cancelButton.isEnabled = true
            }
            searchResultsTableView.isHidden = false
        }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print("Searchbutton Clicker")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textChanged: \(searchText)")
        
        let autoCompleteURL = getAutoCompleteURL(text: searchText.replacingOccurrences(of: " ", with: "-", options: .regularExpression, range: nil))
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

extension HomeController: UICollectionViewDelegate{
    
    // Update HomeCollectionView based on selected category
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.global(qos: .userInteractive).async { [self] in
            categoryCollectionDataSourceAndDelegate.tagsCounter = indexPath.row
        }
        
        let yelpUrl = getYelpURL(lat: 37.786882, lon: -122.399972, category: "\(tags[indexPath.row])")

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
                            self.homeCollectionDataSource.yelpData = result.businesses
                            self.yelpData = result.businesses
                            self.dataStore.yelpBusinessData = result.businesses
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

extension HomeController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
            case "toDetails":
                if let selectedIndexPath = homeCollectionView.indexPathsForSelectedItems!.first{
                    let busTitle = homeCollectionDataSource.yelpData[selectedIndexPath.row].name
                    let address = homeCollectionDataSource.yelpData[selectedIndexPath.row].location.address1
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
