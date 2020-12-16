//
//  WheatherFetcher.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

class WheatherFetcher{
    
    
    func fetchWheatherResults(url: URL, completion: @escaping (WheatherResults?, Error?) -> ()){
        // Session and task
        var request = URLRequest(url: url)
        request.setValue("Bearer \(WheatherAPI.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(nil,error)
            }
            
            let decoder = JSONDecoder()
            
            do{
                let wheatherFeed = try decoder.decode(WheatherResults.self, from: data!)
                
                DispatchQueue.global(qos: .background).async {
                    completion(wheatherFeed, error)
                }
                
            } catch{
                print("Fetching Wheather results error:  \(error.localizedDescription)")
            }
            
        }.resume()
    }
    
}
