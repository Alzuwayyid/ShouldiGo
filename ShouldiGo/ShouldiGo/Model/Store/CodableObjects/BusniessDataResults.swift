//
//  BusniessDataResults.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import Foundation

// MARK: - BusniessDetailsResponse
struct BusniessDetailsResponse: Codable {
//    let id, alias, name: String
//    let imageURL: String
//    let isClaimed, isClosed: Bool
//    let url: String
//    let phone, displayPhone: String
//    let reviewCount: Int
//    let categories: [BusniessCategory]
//    let rating: Double
//    let location: BusniessLocation
//    let coordinates: Coordinates
    let photos: [String]?
//    let price: String
//    let hours: [Hour]
//    let specialHours: [SpecialHour]

    enum CodingKeys: String, CodingKey {
//        case id, alias, name
//        case imageURL = "image_url"
//        case isClaimed = "is_claimed"
//        case isClosed = "is_closed"
//        case url, phone
//        case displayPhone = "display_phone"
//        case reviewCount = "review_count"
//        case categories, rating, location, coordinates, photos, price, hours
//        case specialHours = "special_hours"
        case photos
    }
}

// MARK: - Category
struct BusniessCategory: Codable {
    let alias, title: String
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: Double
}

// MARK: - Hour
struct Hour: Codable {
    let hourOpen: [Open]
    let hoursType: String
    let isOpenNow: Bool

    enum CodingKeys: String, CodingKey {
        case hourOpen = "open"
        case hoursType = "hours_type"
        case isOpenNow = "is_open_now"
    }
}

// MARK: - Open
struct Open: Codable {
    let isOvernight: Bool
    let start, end: String
    let day: Int

    enum CodingKeys: String, CodingKey {
        case isOvernight = "is_overnight"
        case start, end, day
    }
}

// MARK: - Location
struct BusniessLocation: Codable {
    let address1, address2, address3, city: String
    let zipCode, country, state: String
    let displayAddress: [String]
    let crossStreets: String

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
        case crossStreets = "cross_streets"
    }
}

// MARK: - SpecialHour
struct SpecialHour: Codable {
    let date: String
    let isClosed: Bool
    let start, end, isOvernight: JSONNull?

    enum CodingKeys: String, CodingKey {
        case date
        case isClosed = "is_closed"
        case start, end
        case isOvernight = "is_overnight"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
