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
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = daysCollectionViewDD
        daysDetailsCollectionView.delegate = dayDetailsCollectionViewDD
        daysDetailsCollectionView.dataSource = dayDetailsCollectionViewDD
        
        // MARK: - Adding Lines
        addLines()

        
        
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
    
    func addLines(){
        let horzLineView = UIView(frame: CGRect(x: 50, y: 390, width: 273, height: 1.0))
        horzLineView.layer.borderWidth = 1.0
        horzLineView.layer.borderColor = UIColor.white.cgColor
        
        let secondHorzLineView = UIView(frame: CGRect(x: 40, y: 470, width: 300, height: 1.0))
        secondHorzLineView.layer.borderWidth = 1.0
        secondHorzLineView.layer.borderColor = UIColor.white.cgColor
        
        let vertLineView = UIView(frame: CGRect(x: 180, y: 400, width: 1, height: 55.0))
        vertLineView.layer.borderWidth = 1.0
        vertLineView.layer.borderColor = UIColor.white.cgColor

        self.view.addSubview(horzLineView)
        self.view.addSubview(secondHorzLineView)
        self.view.addSubview(vertLineView)
    }
    

}


extension DetailedViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let ForcastTodayURL = getForcastedWheatherURL(lon: -122.399972, lat: 37.786882 ,days: 3)
        
        wheatherFetcher.fetchForcatedWheatherResults(url: ForcastTodayURL) { (result, error) in
            
            var forecast = [ForecastHour]()
            forecast.append(contentsOf: result![indexPath.row].hour)
            self.dayDetailsCollectionViewDD.details = forecast
            self.daysCollectionViewDD.details = result!
            DispatchQueue.main.async {
                self.daysDetailsCollectionView.reloadSections(IndexSet(integer: 0))
            }
        }
    }
    
}
