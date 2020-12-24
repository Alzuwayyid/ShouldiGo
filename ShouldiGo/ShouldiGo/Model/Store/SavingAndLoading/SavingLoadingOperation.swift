//
//  SavingLoadingOperation.swift
//  ShouldiGo
//
//  Created by Mohammed on 22/12/2020.
//

import UIKit

class SavingLoadingOpearion: Operation{
    var reviewsData = [Review]()
    var forcastedWheatherHourly = [ForecastHour]()
    var yelpBusinessData = [Business]()
    var imagesArr = [UIImageView]()

    enum State: String {
        case isReady
        case isExecuting
        case isFinished
    }

    var state: State = .isReady {
        willSet(newValue) {
            willChangeValue(forKey: state.rawValue)
            willChangeValue(forKey: newValue.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
    
    override var isFinished: Bool {
        if isCancelled && state != .isExecuting { return true }
        return state == .isFinished
    }
    
    override var isExecuting: Bool { state == .isExecuting }

    override var isAsynchronous: Bool { true }

    // MARK: - Yelp Business
    let yelpBusinessDataArchiveURL: URL = {
        let documentsDirecorty = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirecorty.first!
        return documentDirectory.appendingPathComponent("YelpBusinessData.plist")
    }()
    
    // MARK: - Hourly Wheather
    let forcastedWheatherHourlyArchiveURL: URL = {
        let documentsDirecorty = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirecorty.first!
        return documentDirectory.appendingPathComponent("ForcastedWheatherHourly.plist")
    }()
    
    // MARK: - Comments
    let reviewsDataArchiveURL: URL = {
        let documentsDirecorty = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirecorty.first!
        return documentDirectory.appendingPathComponent("ReviewsData.plist")
    }()

    // MARK: - Images
    let imagesArchiveURL: URL = {
        let documentsDirecorty = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirecorty.first!
        return documentDirectory.appendingPathComponent("images.plist")
    }()

    
    override func main() {

    }
    
    override func performSelector(inBackground aSelector: Selector, with arg: Any?) {
        
    }
    
    // MARK: - Saving Yelp Business
    func saveYelpBusinessData(){
        let encoder = PropertyListEncoder()
        do{
        let data = try encoder.encode(yelpBusinessData)
        try data.write(to: yelpBusinessDataArchiveURL, options: [.atomic])
            print("-----> Saved yelpBusinessDataArchive")
        }
        catch{
            print("Could not save to the disk")
        }
    }
 
    // MARK: - Save Forcasted Wheather
    func saveForcastedWheatherHourly(){
        let encoder = PropertyListEncoder()
        do{
        let data = try encoder.encode(forcastedWheatherHourly)
        try data.write(to: forcastedWheatherHourlyArchiveURL, options: [.atomic])
            print("-----> Saved yelpBusinessDataArchive")
        }
        catch{
            print("Could not save to the disk")
        }
    }
    
    // MARK: - Save Comments
    func saveReviewsDataArchive(){
        let encoder = PropertyListEncoder()
        do{
        let data = try encoder.encode(reviewsData)
        try data.write(to: reviewsDataArchiveURL, options: [.atomic])
            print("-----> Saved yelpBusinessDataArchive")
        }
        catch{
            print("Could not save to the disk")
        }
    }
    
    // MARK: - Load Yelp Business
    func loadYelpBusinessData(completion: @escaping([Business])->()){
        do{
            let data = try Data(contentsOf: yelpBusinessDataArchiveURL)
            let unArchive = PropertyListDecoder()
            let yelpData = try unArchive.decode([Business].self, from: data)
            yelpBusinessData = yelpData
            completion(yelpData)
        }
        catch{
            print("yelpBusinessData: Encountered some error while loading: \(error)")
        }
        
    }
    
    // MARK: - Load Hourly Wheather
    func loadForcastedWheatherHourly(){
        do{
            let data = try Data(contentsOf: forcastedWheatherHourlyArchiveURL)
            let unArchive = PropertyListDecoder()
            let hourlyWheather = try unArchive.decode([ForecastHour].self, from: data)
            forcastedWheatherHourly = hourlyWheather
        }
        catch{
            print("forcastedWheatherHourly: Encountered some error while loading: \(error)")
        }
        
    }
    
    // MARK: - Load Comments
    func loadReviewsData(){
        do{
            let data = try Data(contentsOf: reviewsDataArchiveURL)
            let unArchive = PropertyListDecoder()
            let comments = try unArchive.decode([Review].self, from: data)
            reviewsData = comments
        }
        catch{
            print("reviewsData: Encountered some error while loading: \(error)")
        }
        
    }
    
    override func start() {
        if isCancelled {
            finish()
            return
        }
        self.state = .isExecuting
        main()
    }
    
    public final func finish() {
        if isExecuting {
            state = .isFinished
        }
    }
    
}
