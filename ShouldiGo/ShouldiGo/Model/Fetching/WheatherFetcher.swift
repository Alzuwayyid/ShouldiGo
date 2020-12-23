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
    
    func fetchForcatedWheatherResults(url: URL, completion: @escaping ([Forecastday]?, Error?) -> ()){
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
                if let data = data{
                    let wheatherFeed = try decoder.decode(WheatherForecastResults.self, from: data)
                    
                    DispatchQueue.global(qos: .background).async {
                        completion(wheatherFeed.forecast?.forecastday, error)
                    }
                }
                
            } catch{
                print("Fetching forcasted Wheather results error:  \(error)")
            }
            
        }.resume()
    }
    
    
    func fetchAutoCompletedResults(url: URL, completion: @escaping ([CountryAutoCompletionResult]?, Error?) -> ()){
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
                if let data = data{
                        let autoCompletion = try decoder.decode([CountryAutoCompletionResult].self, from: data)
                    
                    DispatchQueue.global(qos: .background).async {
                        completion(autoCompletion, error)
                    }
                }
                
            } catch{
                print("Fetching auto completion results error:  \(error)")
            }
            
        }.resume()
    }
    
    
    
}
