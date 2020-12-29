//
//  YelpJsonResults.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

// MARK: - YelpResults
struct YelpResults: Codable {
    let businesses: [Business]?
//    let total: Int
    let region: Region?
}

// MARK: - Business
struct Business: Codable {
    let id, alias, name: String
    let imageURL: String
    let isClosed: Bool
    let url: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let coordinates: Center
    let location: Location?
    let phone, displayPhone: String
    let distance: Double

    enum CodingKeys: String, CodingKey {
        case id, alias, name
        case imageURL = "image_url"
        case isClosed = "is_closed"
        case url
        case reviewCount = "review_count"
        case categories, rating, coordinates, location, phone
        case displayPhone = "display_phone"
        case distance
    }
}

// MARK: - Category
struct Category: Codable {
    let alias, title: String
}

// MARK: - Center
struct Center: Codable {
    let latitude, longitude: Double?
}

// MARK: - Location
struct Location: Codable {
    let address1: String?
    let address2, address3: String?
    let city: String
    let zipCode: String
    let country: String
    let state: String
    let displayAddress: [String]

    enum CodingKeys: String, CodingKey {
        case address1, address2, address3, city
        case zipCode = "zip_code"
        case country, state
        case displayAddress = "display_address"
    }
}

enum City: String, Codable {
    case sanFrancisco = "San Francisco"
}

enum Country: String, Codable {
    case us = "US"
}

enum State: String, Codable {
    case ca = "CA"
}

// MARK: - Region
struct Region: Codable {
    let center: Center?
}


extension Business: Equatable{
    static func == (lhs: Business, rhs: Business)->Bool{
        return lhs.id == rhs.id && lhs.imageURL == rhs.imageURL && lhs.name == rhs.name && lhs.reviewCount == rhs.reviewCount
    }
}
