//
//  YelpFetcher.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

enum YelpError: Error{
    case imageCreationError
    case missingImageURL
}

class YelpFetcher{
    
    
    func fetchYelpResults(url: URL, completion: @escaping ([Business]?, Error?) -> ()){
        
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
                let yelpFeed = try decoder.decode(YelpResults.self, from: data!)
                
                DispatchQueue.global(qos: .background).async {
                    completion(yelpFeed.businesses, error)
                }
                
            } catch{
                print("Fetching Yelp results error:  \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
}
