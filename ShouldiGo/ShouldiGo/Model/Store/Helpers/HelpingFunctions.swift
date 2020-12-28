//
//  ModifyLayersFunctions.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import Foundation
import UIKit
import Alamofire

class modifyLayersFunctions{
    
    func modifyViewLayer(image: inout UIImageView){
        image.layer.borderWidth = 1
        image.layer.cornerRadius = image.frame.height/2.75
        image.layer.masksToBounds = true
        image.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
}

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}


class HelpingMethods{
    func prepareUrlRequest(url: URL, endPoint: String)->URLRequest{
        var request = URLRequest(url: url)
        if endPoint == "Yelp"{
            request = URLRequest(url: url)
            request.setValue("Bearer \(YelpAPI.apiKey)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
        }
        if endPoint == "Weather"{
            request = URLRequest(url: url)
            request.setValue("Bearer \(WheatherAPI.apiKey)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
        }
        
        return request
    }
}

