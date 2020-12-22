//
//  SavingLoadingOperation.swift
//  ShouldiGo
//
//  Created by Mohammed on 22/12/2020.
//

import Foundation

class SavingOpearion{
    var reviewsData = [Review]()
    var forcastedWheatherHourly = [ForecastHour]()
    var yelpBusinessData = [Business]()
    
    enum State: String {
        case isReady
        case isExecuting
        case isFinished
    }

}
