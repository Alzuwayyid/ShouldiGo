//
//  WheatherAPI.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

struct WheatherAPI{
   static let apiKey = "2897f5267bb74f0cb0b133633201612"
}

enum WheatherEndPoints{
    
    static let search = "http://api.weatherapi.com/v1/current.json?"
    static let http = "http:"
    case searchURLString(Double, Double, Int)
    case wheatherImageURL(String)
    
    var baseURL: String {
        switch self {
            case .searchURLString(let lon, let lat, let days):
                return WheatherEndPoints.search + "key=\(WheatherAPI.apiKey)" + "&q=" + "\(lat)" + ",\(lon)" + "&days=\(days)"
            case .wheatherImageURL(let imageURL):
                return WheatherEndPoints.http + "\(imageURL)"
        }
    }
    
    var url: URL {
        return URL(string: baseURL)!
    }
    
    var string: String {
        return String(baseURL)
    }
}

func getWheatherImageURL(imageURL: String)->String{
    return WheatherEndPoints.wheatherImageURL(imageURL).string
}

func getWheatherURL(lon: Double, lat: Double, days: Int)->URL{
    return WheatherEndPoints.searchURLString(lon,lat, days).url
}
