//
//  WheatherFetcher.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

class WheatherFetcher{
    // MARK: - Properities
    var helpingMethods = HelpingMethods()

    // MARK: - Fetching current whather results
    func fetchWheatherResults(url: URL, completion: @escaping (WheatherResults?, Error?) -> ()){
        // Session and task
        let decoder = JSONDecoder()
        let request = helpingMethods.prepareUrlRequest(url: url, endPoint: "Weather")

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil,error)
            }
            
            do{
                let wheatherFeed = try decoder.decode(WheatherResults.self, from: data!)
                DispatchQueue.global(qos: .background).async {
                    completion(wheatherFeed, error)
                }
            }catch{
                print("Fetching Wheather results error:  \(error.localizedDescription)")
            }
        }.resume()
    }
    
    // MARK: - Fetching forcasted wheather resutls
    func fetchForcatedWheatherResults(url: URL, completion: @escaping ([Forecastday]?, Error?) -> ()){
        // Session and task
        let decoder = JSONDecoder()
        let request = helpingMethods.prepareUrlRequest(url: url, endPoint: "Weather")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil,error)
            }
            
            do{
                if let data = data{
                    let wheatherFeed = try decoder.decode(WheatherForecastResults.self, from: data)
                    DispatchQueue.global(qos: .background).async {
                        completion(wheatherFeed.forecast?.forecastday, error)
                    }
                }
            }catch{
                print("Fetching forcasted Wheather results error:  \(error)")
            }
        }.resume()
    }
    
    // MARK: - Fetching autocompleted regions results
    func fetchAutoCompletedResults(url: URL, completion: @escaping ([CountryAutoCompletionResult]?, Error?) -> ()){
        // Session and task
        let decoder = JSONDecoder()
        let request = helpingMethods.prepareUrlRequest(url: url, endPoint: "Weather")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil,error)
            }
            
            do{
                if let data = data{
                    let autoCompletion = try decoder.decode([CountryAutoCompletionResult].self, from: data)
                    DispatchQueue.global(qos: .background).async {
                        completion(autoCompletion, error)
                    }
                }
            }catch{
                print("Fetching auto completion results error:  \(error)")
            }
        }.resume()
    }
}
