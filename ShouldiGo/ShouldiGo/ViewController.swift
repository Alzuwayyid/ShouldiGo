//
//  ViewController.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var fetcher = YelpFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = getYelpURL(lat: 37.786882, lon: -122.399972, category: "resturants")
            
        fetcher.fetchYelpResults(url: url) { (result, error) in
            print("Result: GGeGG \(result!)")
        }
    }

    

}

