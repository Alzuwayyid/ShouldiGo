//
//  TableView+HomeController.swift
//  ShouldiGo
//
//  Created by Mohammed on 29/12/2020.
//

import UIKit
import Alamofire

// MARK: - SearchBarTableView delegate
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

