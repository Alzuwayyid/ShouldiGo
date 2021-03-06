//
//  YelpAPI.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

struct YelpAPI{
//   static let clientId = "blotHY6hW3C8NGLvaVBQNg"
//   static let apiKey = "oPsg-iC559Lpu1Flh6qxRtC8z84tMNHJ-e0mBhxxZw-lQxa78erFfCqg-c2SZXqNmL0bRUC4xdtXo8fIybLsNIEejaqQZFd-_oKuVvHm87doaLbX1psTN0ZxQdvZX3Yx"
    
    static let clientId = "HpOlnhat6pf7BKE8Fj6JsQ"
    static let apiKey = "9CeLwpPSi77RPZRq2jJF-UHQPeu8PsZuwGEUPD-32Xy170976HbZAXRzbzD3k1Q7IpIQVIuVrJjTIiN48PdpbZgbteaRC_BqA1dtUlc69S7cOqnDwJh-iO0UZYjjX3Yx"
}

enum YelpEndPoints{
    
    static let search = "https://api.yelp.com/v3/businesses/search?"
    static let fetchBusinessIdDataBaseURL = "https://api.yelp.com/v3/businesses/"
    static let autoCompleteEndPoint = "https://api.yelp.com/v3/autocomplete?"
    
    case searchURLString(Double,Double,String)
    case businessId(String)
    case autoCompleteText(String)
    case reviews(String)
    case yelpAutoCompletedURL(Double,Double,String)
    case yelpBusinessByCountryURL(String, String)

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
            case .reviews(let id):
                return YelpEndPoints.fetchBusinessIdDataBaseURL + "\(id)" + "/reviews"
            case .yelpBusinessByCountryURL(let location, let category):
                return YelpEndPoints.search + "term=\(category)" + "&location=\(location)"
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

func getReviewsURL(id: String)->URL{
    return YelpEndPoints.reviews(id).url
}

func getBusinessByLocation(location: String, category: String)->URL{
    return YelpEndPoints.yelpBusinessByCountryURL(location, category).url
}
