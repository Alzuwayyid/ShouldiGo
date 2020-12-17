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

    case searchURLString(Double,Double,String)
    case businessId(String)

    var baseURL: String {
        switch self {
            case .searchURLString(let lat, let lon, let category):
                return YelpEndPoints.search + "term=delis" + "&latitude=\(lat)" + "&longitude=\(lon)" + "&categories=\(category)"
            case .businessId(let id):
                return YelpEndPoints.fetchBusinessIdDataBaseURL + "\(id)"
        }
    }
    
    var url: URL {
        return URL(string: baseURL)!
    }
    
}

func getYelpURL(lat: Double, lon: Double, category: String)->URL{
    return YelpEndPoints.searchURLString(lat, lon, category).url
}

func getBusinessIdURL(id: String)->URL{
    return YelpEndPoints.businessId(id).url
}

