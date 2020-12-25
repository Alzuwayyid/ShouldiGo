//
//  wheatherJsonResults.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

struct WheatherResults: Codable {
    let location: WheatherLocation
    let current: Current
}

// MARK: - Current
struct Current: Codable {
    let tempC: Double
    let condition: Condition
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String
    let code: Int
}

// MARK: - Location
struct WheatherLocation: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}
