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
        image.layer.cornerRadius = image.frame.height/2.75 //85
        image.layer.masksToBounds = true
        image.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
}

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

extension UIImageView {

    func setImageFromURL(url: String) {

        DispatchQueue.global().async {

            let data = NSData.init(contentsOf: NSURL.init(string: url)! as URL)
            DispatchQueue.main.async {

                let image = UIImage.init(data: data! as Data)
                self.image = image
            }
        }
    }
}
