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
//    let lastUpdatedEpoch: Int
//    let lastUpdated: String
    let tempC: Double
//    let tempF, isDay: Int
    let condition: Condition
//    let windMph, windKph: Double
//    let windDegree: Int
//    let windDir: String
//    let pressureMB: Int
//    let pressureIn, precipMm, precipIn: Double
//    let humidity, cloud: Int
//    let feelslikeC: Double
//    let feelslikeF, visKM, visMiles, uv: Int
//    let gustMph, gustKph: Double

    enum CodingKeys: String, CodingKey {
//        case lastUpdatedEpoch = "last_updated_epoch"
//        case lastUpdated = "last_updated"
        case tempC = "temp_c"
//        case tempF = "temp_f"
//        case isDay = "is_day"
        case condition
//        case windMph = "wind_mph"
//        case windKph = "wind_kph"
//        case windDegree = "wind_degree"
//        case windDir = "wind_dir"
//        case pressureMB = "pressure_mb"
//        case pressureIn = "pressure_in"
//        case precipMm = "precip_mm"
//        case precipIn = "precip_in"
//        case humidity, cloud
//        case feelslikeC = "feelslike_c"
//        case feelslikeF = "feelslike_f"
//        case visKM = "vis_km"
//        case visMiles = "vis_miles"
//        case uv
//        case gustMph = "gust_mph"
//        case gustKph = "gust_kph"
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