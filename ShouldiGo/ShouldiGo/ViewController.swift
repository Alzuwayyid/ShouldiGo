//
//  ViewController.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

class ViewController: UIViewController {
    
    var yelpFetcher = YelpFetcher()
    var wheatherFetcher = WheatherFetcher()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = getYelpURL(lat: 37.786882, lon: -122.399972, category: "resturants")
        let wURL = getWheatherURL(lon: -122.399972, lat: 37.786882)
        
        print("wURL: \(wURL)")
        
        wheatherFetcher.fetchWheatherResults(url: wURL) { (current, error) in
            print("GEgeGe:  \(current!)")
        }
    }

    

}

