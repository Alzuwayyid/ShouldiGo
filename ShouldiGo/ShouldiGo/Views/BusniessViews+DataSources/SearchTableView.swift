//
//  SearchTableView.swift
//  ShouldiGo
//
//  Created by Mohammed on 19/12/2020.
//

import UIKit

class SearchTableView: NSObject ,UITableViewDelegate, UITableViewDataSource {
    
    let deleteMeArr = ["Xcode","is","Fucking","Crap"]
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        deleteMeArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reuseIdentifier = "searchTable"
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        cell.textLabel?.text = deleteMeArr[indexPath.row]
        return cell
    }
    



}
