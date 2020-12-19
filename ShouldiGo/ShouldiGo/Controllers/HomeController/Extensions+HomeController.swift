//
//  Extensions+HomeController.swift
//  ShouldiGo
//
//  Created by Mohammed on 19/12/2020.
//

import UIKit

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard autoCompleteArr.count > 0 else{
            return 0
        }
        return autoCompleteArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let reuseIdentifier = "searchTable"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = "\(autoCompleteArr[indexPath.row].text)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if autoCompleteArr.count > 0 {
            let yelpUrl = getYelpAutoCompletedURL(lat: 37.786882, lon: -122.399972, category: autoCompleteArr[indexPath.row].text)
            yelpFetcher.fetchYelpResults(url: yelpUrl) { (result, error) in
                self.homeCollectionDataSource.yelpData = result!.businesses
                self.yelpData = result!.businesses
                DispatchQueue.main.async {
                    self.homeCollectionView.reloadSections(IndexSet(integer: 0))
                }
            }
            self.searchResultsTableView.isHidden = true
        }
    }
}



extension HomeController: UISearchBarDelegate/*, UISearchResultsUpdating*/{
    
//    func updateSearchResults(for searchController: UISearchController) {
//        <#code#>
//    }
//
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
        
        let autoCompleteURL = getAutoCompleteURL(text: searchText)
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
        yelpFetcher.fetchYelpResults(url: yelpUrl) { (result, error) in
            self.homeCollectionDataSource.yelpData = result!.businesses
            DispatchQueue.main.async {
                self.homeCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
}
