//
//  DetailsViewController.swift
//  ShouldiGo
//
//  Created by Mohammed on 20/12/2020.
//

import UIKit
import Kingfisher
import MapKit
import Alamofire

class DetailedViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var daysDetailsCollectionView: UICollectionView!
    @IBOutlet var daysCollectionView: UICollectionView!
    @IBOutlet var largeImage: UIImageView!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var phoneNumber: UILabel!
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var locationButton: UIButton!
    @IBOutlet var commentsButton: UIButton!
    
    // MARK: - Properties
    let dayDetailsCollectionViewDD = DaysDetailsCollectionViewDataSourceAndDelegate()
    let daysCollectionViewDD = DaysCollectionViewDataSourceAndDelegate()
    let wheatherFetcher = WheatherFetcher()
    var latitude = 0.0
    var longitude = 0.0
    var addressText = ""
    var nameText = ""
    var ratingText = ""
    var titleText = ""
    var largeImageURL = ""
    var phoneNumberText = ""
    var categoryText = ""
    var busID = ""
    var dataStore =  DataStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Delegation
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = daysCollectionViewDD
        daysDetailsCollectionView.delegate = dayDetailsCollectionViewDD
        daysDetailsCollectionView.dataSource = dayDetailsCollectionViewDD
        
        // MARK: - Adding Lines
        addLines()
        
        // MARK: - Assigning values to views
        phoneNumber.text = phoneNumberText
        titleLabel.text = titleText
        addressLabel.text = addressText
        ratingLabel.text = ratingText
        categoryLabel.text = categoryText
        largeImage.kf.setImage(with: URL(string: largeImageURL))
        
        
        largeImage.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner]
        largeImage.layer.masksToBounds = true
        largeImage.layer.cornerRadius = 15
        
        // MARK: - Check internt connectivity
        let networkManager = NetworkReachabilityManager()
        
        // Fetch data for categories and location
        networkManager?.startListening(onUpdatePerforming: { (status) in
            switch status{
                
                case .unknown:
                    print("Unknown")
                case .notReachable:
                    self.dataStore.loadForcastedDailyData { (result) in
                        var forecast = [ForecastHour]()
                        if !result.isEmpty{
                            for index in 0...result.count-1{
                                forecast.append(contentsOf: result[index].hour)
                                self.dayDetailsCollectionViewDD.details = forecast
                                self.daysCollectionViewDD.details = result
                                DispatchQueue.main.async {
                                    self.daysDetailsCollectionView.reloadSections(IndexSet(integer: 0))
                                    self.daysCollectionView.reloadSections(IndexSet(integer: 0))
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            self.commentsButton.backgroundColor = .black
                            self.commentsButton.isEnabled = false
                        }
                    }
                case .reachable(_):
                    // MARK: - Update wheather results
                    let ForcastTodayURL = getForcastedWheatherURL(lon: self.longitude, lat: self.latitude ,days: 3)
                    self.wheatherFetcher.fetchForcatedWheatherResults(url: ForcastTodayURL) { (result, error) in
                        var forecast = [ForecastHour]()
                        if let result = result{
                            for index in 0...result.count-1{
                                forecast.append(contentsOf: result[index].hour)
                            }
                            self.dayDetailsCollectionViewDD.details = forecast
                            self.daysCollectionViewDD.details = result
                            self.dataStore.forcastedWheatherDay = result
                            self.dataStore.saveChangesToWheather()
                            DispatchQueue.main.async {
                                self.daysDetailsCollectionView.reloadSections(IndexSet(integer: 0))
                                self.daysCollectionView.reloadSections(IndexSet(integer: 0))
                            }
                        }
                    }
            }
        })
        

    }
    
    @IBAction func dismissController(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Open location in apple maps
    @IBAction func openAppleMaps(_ sender: UIButton) {
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = nameText
        mapItem.openInMaps(launchOptions: options)
    }
    
    // Drawing lines in the super view
    func addLines(){
        let horzLineView = UIView(frame: CGRect(x: 50, y: 265, width: 273, height: 1.0))
        horzLineView.layer.borderWidth = 1.0
        horzLineView.layer.borderColor = UIColor.white.cgColor
        
        let secondHorzLineView = UIView(frame: CGRect(x: 40, y: 340, width: 300, height: 1.0))
        secondHorzLineView.layer.borderWidth = 1.0
        secondHorzLineView.layer.borderColor = UIColor.white.cgColor
        
        let vertLineView = UIView(frame: CGRect(x: 180, y: 275, width: 1, height: 55.0))
        vertLineView.layer.borderWidth = 1.0
        vertLineView.layer.borderColor = UIColor.white.cgColor

        self.view.addSubview(horzLineView)
        self.view.addSubview(secondHorzLineView)
        self.view.addSubview(vertLineView)
    }
    

}


extension DetailedViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let ForcastTodayURL = getForcastedWheatherURL(lon: longitude, lat: latitude ,days: 3)
        
        wheatherFetcher.fetchForcatedWheatherResults(url: ForcastTodayURL) { (result, error) in
            
            var forecast = [ForecastHour]()
            // will avoid crashing in offline mode if no value was passed from forcaste api to a partircular business, by unrawpping and checking emptiness.
            if let result = result{
                if !result.isEmpty{
                    forecast.append(contentsOf: result[indexPath.row].hour)
                    self.dayDetailsCollectionViewDD.details = forecast
                    self.daysCollectionViewDD.details = result
                    DispatchQueue.main.async {
                        self.daysDetailsCollectionView.reloadSections(IndexSet(integer: 0))
                    }
                }
            }
        }
    }
    
}


extension DetailedViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
            case "commentSegue":
                let decVC = segue.destination as! CommentsViewController
                decVC.busID = busID
            default:
                print("Could not prefrom segue")
        }

    }
    
}
