//
//  ModifyLayersFunctions.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import Foundation
import UIKit

class modifyLayersFunctions{
    
    func modifyViewLayer(image: inout UIImageView){
        image.layer.borderWidth = 1
        image.layer.cornerRadius = image.frame.height/2.75 //85
        image.layer.masksToBounds = true
        image.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
}