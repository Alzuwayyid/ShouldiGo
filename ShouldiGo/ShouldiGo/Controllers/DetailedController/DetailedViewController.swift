//
//  DetailsViewController.swift
//  ShouldiGo
//
//  Created by Mohammed on 20/12/2020.
//

import UIKit

class DetailedViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var daysDetailsCollectionView: UICollectionView!
    @IBOutlet var daysCollectionView: UICollectionView!
    
    
    // MARK: - Properties
    let dayDetailsCollectionViewDD = DaysDetailsCollectionViewDataSourceAndDelegate()
    let daysCollectionViewDD = DaysCollectionViewDataSourceAndDelegate()
    let wheatherFetcher = WheatherFetcher()
    var latitude = 0.0
    var longitude = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Delegation
        daysCollectionView.delegate = daysCollectionViewDD
        daysCollectionView.dataSource = daysCollectionViewDD
        daysDetailsCollectionView.delegate = dayDetailsCollectionViewDD
        daysDetailsCollectionView.dataSource = dayDetailsCollectionViewDD
        
        let ForcastTodayURL = getForcastedWheatherURL(lon: -122.399972, lat: 37.786882 ,days: 3)
        wheatherFetcher.fetchForcatedWheatherResults(url: ForcastTodayURL) { (result, error) in
            var forecast = [ForecastHour]()
            for index in 0...result!.count-1{
                forecast.append(contentsOf: result![index].hour)
            }
            self.dayDetailsCollectionViewDD.details = forecast
            self.daysCollectionViewDD.details = result!
            DispatchQueue.main.async {
                self.daysDetailsCollectionView.reloadSections(IndexSet(integer: 0))
                self.daysCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    

}
