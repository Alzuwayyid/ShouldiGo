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
    
//    func fetchImage(for photo: Business, completion: @escaping (Result<UIImage, Error>)->Void){
//        let photoKey = photo.id
//
//        if let image = imageStore.image(forKey: photoKey){
//            OperationQueue.main.addOperation{
//                completion(.success(image))
//            }
//            return
//        }
//
//        guard let photoURL = URL(string: photo.imageURL) else{
//            completion(.failure(PhotoError.missingImageURL))
//            return
//        }
//
//        var request = URLRequest(url: photoURL)
//        request.setValue("Bearer \(YelpAPI.apiKey)", forHTTPHeaderField: "Authorization")
//        request.httpMethod = "GET"
//
//        let task = session.dataTask(with: request){
//            (data, response, error) in
//
//
//            let result = self.processImageRequest(data: data, error: error)
//
//            if case let .success(image) = result{
//                self.imageStore.setImage(image, forKey: photoKey)
//            }
//            OperationQueue.main.addOperation {
//                completion(result)
//            }
//
//        }
//        task.resume()
//    }
    
//    let session: URLSession = {
//       let config = URLSessionConfiguration.default
//       return URLSession(configuration: config)
//   }()
//
//
//    func processImageRequest(data: Data?, error: Error?)->Result<UIImage, Error> {
//       guard let imageData = data, let image = UIImage(data: imageData) else{
//           // Could not create the image
//           if data == nil {
//               return .failure(error!)
//           }
//           else{
//               return .failure(PhotoError.imageCreationError)
//           }
//       }
//       return .success(image)
//   }
    
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
                print("Fetching AutoComplete results error:  \(error.localizedDescription)")
            }
            
        }.resume()
        
    }
    
}
