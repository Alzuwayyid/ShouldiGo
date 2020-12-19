//
//  YelpAPI.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

struct YelpAPI{
   static let clientId = "blotHY6hW3C8NGLvaVBQNg"
   static let apiKey = "oPsg-iC559Lpu1Flh6qxRtC8z84tMNHJ-e0mBhxxZw-lQxa78erFfCqg-c2SZXqNmL0bRUC4xdtXo8fIybLsNIEejaqQZFd-_oKuVvHm87doaLbX1psTN0ZxQdvZX3Yx"
}

enum YelpEndPoints{
    
    static let search = "https://api.yelp.com/v3/businesses/search?"
    static let fetchBusinessIdDataBaseURL = "https://api.yelp.com/v3/businesses/"
    static let autoCompleteEndPoint = "https://api.yelp.com/v3/autocomplete?"
    
    case searchURLString(Double,Double,String)
    case businessId(String)
    case autoCompleteText(String)
    case yelpAutoCompletedURL(Double,Double,String)

    var baseURL: String {
        switch self {
            case .searchURLString(let lat, let lon, let category):
                return YelpEndPoints.search  + "term=\(category)?" + "&latitude=\(lat)" + "&longitude=\(lon)"
            case .businessId(let id):
                return YelpEndPoints.fetchBusinessIdDataBaseURL + "\(id)"
            case .autoCompleteText(let text):
                return YelpEndPoints.autoCompleteEndPoint + "text=\(text)"
            case .yelpAutoCompletedURL(let lat, let lon, let category):
                return YelpEndPoints.search  + "term=\(category)?" + "&latitude=\(lat)" + "&longitude=\(lon)"
        }
    }
    
    var url: URL {
        return URL(string: baseURL)!
    }
    
}

func getYelpURL(lat: Double, lon: Double, category: String)->URL{
    return YelpEndPoints.searchURLString(lat, lon, category).url
}

func getYelpAutoCompletedURL(lat: Double, lon: Double, category: String)->URL{
    return YelpEndPoints.searchURLString(lat, lon, category.replacingOccurrences(of: " ", with: "-", options: .regularExpression, range: nil)).url
}

func getBusinessIdURL(id: String)->URL{
    return YelpEndPoints.businessId(id).url
}

func getAutoCompleteURL(text: String)-> URL{
    return YelpEndPoints.autoCompleteText(text).url
}
