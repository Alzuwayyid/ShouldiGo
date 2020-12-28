//
//  YelpFetcher.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

enum PhotoError: Error{
    case imageCreationError
    case missingImageURL
}

class YelpFetcher{
    // MARK: - Properities
    var helpingMethods = HelpingMethods()
    
    // MARK: - Fetching All results
    func fetchYelpResults(url: URL, completion: @escaping (YelpResults?, Error?) -> ()){
        // Creating request
        let decoder = JSONDecoder()
        let request = helpingMethods.prepareUrlRequest(url: url, endPoint: "Yelp")
        
        // Session and task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil,error)
            }
            
            do{
                if let data = data{
                    let yelpFeed = try decoder.decode(YelpResults.self, from: data)
                    DispatchQueue.global(qos: .background).async {
                        completion(yelpFeed, error)
                    }
                }
                DispatchQueue.global(qos: .background).async {
                    completion(nil, error)
                }
            } catch{
                print("Fetching Yelp results error:  \(error)")
            }
        }.resume()
    }
     
    // MARK: - Fetching Business Details
    func fetchBusniessDetails(url: URL, completion: @escaping (BusniessDetailsResponse?, Error?) -> ()){
        // Creating request
        let decoder = JSONDecoder()
        let request = helpingMethods.prepareUrlRequest(url: url, endPoint: "Yelp")

        // Session and task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil,error)
            }
            
            do{
                let yelpByIdFeed = try decoder.decode(BusniessDetailsResponse.self, from: data!)
                DispatchQueue.global(qos: .background).async {
                    completion(yelpByIdFeed, error)
                }
            }catch{
                print("Fetching Yelp data results error:  \(error)")
            }
            
        }.resume()
        
    }

    // MARK: - Fetching reviews
    func fetchYelpReviewsResults(url: URL, completion: @escaping (YelpReviewsResult?, Error?) -> ()){
        // Creating request
        let decoder = JSONDecoder()
        let request = helpingMethods.prepareUrlRequest(url: url, endPoint: "Yelp")

        // Session and task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil,error)
            }
            
            do{
                let yelpFeed = try decoder.decode(YelpReviewsResult.self, from: data!)
                DispatchQueue.global(qos: .background).async {
                    completion(yelpFeed, error)
                }
            }catch{
                print("Fetching Yelp Reviews results error:  \(error)")
            }
            
        }.resume()
    }
    
    // MARK: - Fetching autocompleted search results
    func fetchAutoCompleteResults(url: URL, completion: @escaping (AutoCompleteResults?, Error?) -> ()){
        // Creating request
        let decoder = JSONDecoder()
        let request = helpingMethods.prepareUrlRequest(url: url, endPoint: "Yelp")

        // Session and task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil,error)
            }
            
            do{
                let yelpByIdFeed = try decoder.decode(AutoCompleteResults.self, from: data!)
                DispatchQueue.global(qos: .background).async {
                    completion(yelpByIdFeed, error)
                }
            }catch{
                print("Fetching AutoComplete results error:  \(error)")
            }
        }.resume()
    }
}
