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
    private let imageStore = ImageStore()

    
    func fetchYelpResults(url: URL, completion: @escaping (YelpResults?, Error?) -> ()){
        
        // Creating request
        var request = URLRequest(url: url)
        request.setValue("Bearer \(YelpAPI.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        // Session and task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil,error)
            }
            
            let decoder = JSONDecoder()
            
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
     
    func fetchBusniessDetails(url: URL, completion: @escaping (BusniessDetailsResponse?, Error?) -> ()){
        var request = URLRequest(url: url)
        request.setValue("Bearer \(YelpAPI.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        // Session and task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil,error)
            }
            
            let decoder = JSONDecoder()
            
            do{
                let yelpByIdFeed = try decoder.decode(BusniessDetailsResponse.self, from: data!)
                
                DispatchQueue.global(qos: .background).async {
                    completion(yelpByIdFeed, error)
                }
                
            } catch{
                print("Fetching Yelp data results error:  \(error)")
            }
            
        }.resume()
        
    }
  
    
    
    func fetchYelpReviewsResults(url: URL, completion: @escaping (YelpReviewsResult?, Error?) -> ()){
        
        // Creating request
        var request = URLRequest(url: url)
        request.setValue("Bearer \(YelpAPI.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        // Session and task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil,error)
            }
            
            let decoder = JSONDecoder()
            
            do{
                let yelpFeed = try decoder.decode(YelpReviewsResult.self, from: data!)
                
                DispatchQueue.global(qos: .background).async {
                    completion(yelpFeed, error)
                }
                
            } catch{
                print("Fetching Yelp Reviews results error:  \(error)")
            }
            
        }.resume()
    }
    
    
    func fetchAutoCompleteResults(url: URL, completion: @escaping (AutoCompleteResults?, Error?) -> ()){
        var request = URLRequest(url: url)
        request.setValue("Bearer \(YelpAPI.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        // Session and task
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil,error)
            }
            
            let decoder = JSONDecoder()
            
            do{
                let yelpByIdFeed = try decoder.decode(AutoCompleteResults.self, from: data!)
                
                DispatchQueue.global(qos: .background).async {
                    completion(yelpByIdFeed, error)
                }
                
            } catch{
                print("Fetching AutoComplete results error:  \(error)")
            }
            
        }.resume()
        
    }
    
}
