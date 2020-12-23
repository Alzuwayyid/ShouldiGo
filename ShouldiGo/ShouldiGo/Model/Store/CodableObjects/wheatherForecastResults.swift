//
//  wheatherForecastResults.swift
//  ShouldiGo
//
//  Created by Mohammed on 20/12/2020.
//

import Foundation
//
//// MARK: - WheatherForecastResults
//struct WheatherForecastResults: Codable {
//    let location: WheatherLocation
//    let current: CurrentWheather
//    let forecast: Forecast
//    let alert: Alert
//}
//
//// MARK: - Alert
//struct Alert: Codable {
//}
//
//// MARK: - Current
//struct CurrentWheather: Codable {
//    let lastUpdatedEpoch: Int
//    let lastUpdated: String
//    let tempC: Double
//    let tempF, isDay: Int
//    let condition: ForecastCondition
//    let windMph, windKph: Double
//    let windDegree: Int
//    let windDir: String
//    let pressureMB: Int
//    let pressureIn: Double
//    let precipMm, precipIn, humidity, cloud: Int
//    let feelslikeC, feelslikeF: Double
//    let visKM, visMiles, uv, gustMph: Int
//    let gustKph: Double
//
//    enum CodingKeys: String, CodingKey {
//        case lastUpdatedEpoch = "last_updated_epoch"
//        case lastUpdated = "last_updated"
//        case tempC = "temp_c"
//        case tempF = "temp_f"
//        case isDay = "is_day"
//        case condition
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
//    }
//}
//
//// MARK: - Condition
//struct ForecastCondition: Codable {
//    let text: Text
//    let icon: String
//    let code: Int
//}
//
//enum Text: String, Codable {
//    case clear = "Clear"
//    case cloudy = "Cloudy"
//    case lightDrizzle = "Light drizzle"
//    case overcast = "Overcast"
//    case partlyCloudy = "Partly cloudy"
//    case patchyRainPossible = "Patchy rain possible"
//    case sunny = "Sunny"
//}
//
//// MARK: - Forecast
//struct Forecast: Codable {
//    let forecastday: [Forecastday]
//}
//
//// MARK: - Forecastday
//struct Forecastday: Codable {
//    let date: String
////    let dateEpoch: Int
//    let day: Day
//    let astro: Astro
//    let hour: [ForecastHour]
//
//    enum CodingKeys: String, CodingKey {
//        case date
////        case dateEpoch = "date_epoch"
//        case day, astro, hour
//    }
//}
//
//// MARK: - Astro
//struct Astro: Codable {
//    let sunrise, sunset, moonrise, moonset: String
//    let moonPhase, moonIllumination: String
//
//    enum CodingKeys: String, CodingKey {
//        case sunrise, sunset, moonrise, moonset
//        case moonPhase = "moon_phase"
//        case moonIllumination = "moon_illumination"
//    }
//}
//
//// MARK: - Day
//struct Day: Codable {
//    let maxtempC, maxtempF, mintempC, mintempF: Double
//    let avgtempC, avgtempF, maxwindMph, maxwindKph: Double
//    let totalprecipMm, totalprecipIn: Double
//    let avgvisKM, avgvisMiles, avghumidity, dailyWillItRain: Int
//    let dailyChanceOfRain: String
//    let dailyWillItSnow: Int
//    let dailyChanceOfSnow: String
//    let condition: Condition
//    let uv: Int
//
//    enum CodingKeys: String, CodingKey {
//        case maxtempC = "maxtemp_c"
//        case maxtempF = "maxtemp_f"
//        case mintempC = "mintemp_c"
//        case mintempF = "mintemp_f"
//        case avgtempC = "avgtemp_c"
//        case avgtempF = "avgtemp_f"
//        case maxwindMph = "maxwind_mph"
//        case maxwindKph = "maxwind_kph"
//        case totalprecipMm = "totalprecip_mm"
//        case totalprecipIn = "totalprecip_in"
//        case avgvisKM = "avgvis_km"
//        case avgvisMiles = "avgvis_miles"
//        case avghumidity
//        case dailyWillItRain = "daily_will_it_rain"
//        case dailyChanceOfRain = "daily_chance_of_rain"
//        case dailyWillItSnow = "daily_will_it_snow"
//        case dailyChanceOfSnow = "daily_chance_of_snow"
//        case condition, uv
//    }
//}
//
//// MARK: - Hour
//struct ForecastHour: Codable {
//    let timeEpoch: Int
//    let time: String
//    let tempC, tempF: Double
//    let isDay: Int
//    let condition: Condition
//    let windMph, windKph: Double
//    let windDegree: Int
//    let windDir: String
//    let pressureMB: Int
//    let pressureIn, precipMm, precipIn: Double
//    let humidity, cloud: Int
//    let feelslikeC, feelslikeF, windchillC, windchillF: Double
//    let heatindexC, heatindexF, dewpointC, dewpointF: Double
//    let willItRain: Int
//    let chanceOfRain: String
//    let willItSnow: Int
//    let chanceOfSnow: String
//    let visKM: Double
//    let visMiles: Int
//    let gustMph, gustKph: Double
//
//    enum CodingKeys: String, CodingKey {
//        case timeEpoch = "time_epoch"
//        case time
//        case tempC = "temp_c"
//        case tempF = "temp_f"
//        case isDay = "is_day"
//        case condition
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
//        case windchillC = "windchill_c"
//        case windchillF = "windchill_f"
//        case heatindexC = "heatindex_c"
//        case heatindexF = "heatindex_f"
//        case dewpointC = "dewpoint_c"
//        case dewpointF = "dewpoint_f"
//        case willItRain = "will_it_rain"
//        case chanceOfRain = "chance_of_rain"
//        case willItSnow = "will_it_snow"
//        case chanceOfSnow = "chance_of_snow"
//        case visKM = "vis_km"
//        case visMiles = "vis_miles"
//        case gustMph = "gust_mph"
//        case gustKph = "gust_kph"
//    }
//}
//






// MARK: - WheatherForecastResults
struct WheatherForecastResults: Codable {
    let location: ForcastedLocation
    let current: CurrentForcasted
    let forecast: Forecast?
    let alert: Alert
}

// MARK: - Alert
struct Alert: Codable {
}

// MARK: - Current
struct CurrentForcasted: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: ConditionForcasted
    let windMph, windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMB: Int
    let pressureIn: Double
    let precipMm, precipIn, humidity, cloud: Int
    let feelslikeC, feelslikeF: Double
    let visKM, visMiles, uv: Int
    let gustMph, gustKph: Double

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

// MARK: - Condition
struct ConditionForcasted: Codable {
    let text: Text
    let icon: String
    let code: Int
}

enum Text: String, Codable {
    case clear = "Clear"
    case cloudy = "Cloudy"
    case lightDrizzle = "Light drizzle"
    case overcast = "Overcast"
    case partlyCloudy = "Partly cloudy"
    case patchyRainPossible = "Patchy rain possible"
    case sunny = "Sunny"
}

// MARK: - Forecast
struct Forecast: Codable {
    let forecastday: [Forecastday]?
}

// MARK: - Forecastday
struct Forecastday: Codable {
    let date: String
    let dateEpoch: Int
    let day: Day
    let astro: Astro
    let hour: [ForecastHour]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
}

// MARK: - Astro
struct Astro: Codable {
    let sunrise, sunset, moonrise, moonset: String
    let moonPhase, moonIllumination: String

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
    }
}

// MARK: - Day
struct Day: Codable {
    let maxtempC, maxtempF, mintempC, mintempF: Double
    let avgtempC, avgtempF, maxwindMph, maxwindKph: Double
    let totalprecipMm, totalprecipIn: Double
    let avgvisKM, avgvisMiles, avghumidity: Double?
    let dailyChanceOfRain: String
    let dailyWillItSnow: Int
    let dailyChanceOfSnow: String
    let condition: Condition
    let uv: Int

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case avgvisKM = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition, uv
    }
}

// MARK: - Hour
struct ForecastHour: Codable {
    let timeEpoch: Int
    let time: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph, windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMB: Int
    let pressureIn, precipMm, precipIn: Double
    let humidity, cloud: Int
    let feelslikeC, feelslikeF, windchillC, windchillF: Double
    let heatindexC, heatindexF, dewpointC, dewpointF: Double
    let willItRain: Int
    let chanceOfRain: String
    let willItSnow: Int
    let chanceOfSnow: String
    let visKM: Double
    let visMiles: Int
    let gustMph, gustKph: Double

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

// MARK: - Location
struct ForcastedLocation: Codable {
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
