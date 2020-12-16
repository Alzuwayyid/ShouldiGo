//
//  YelpJsonResults.swift
//  ShouldiGo
//
//  Created by Mohammed on 16/12/2020.
//

import UIKit

    // MARK: - Welcome
    struct YelpResults: Codable {
        let businesses: [Business]
        let total: Int
        let region: Region
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
        let transactions: [Transaction]
        let price: Price?
        let location: Location
        let phone, displayPhone: String
        let distance: Double

        enum CodingKeys: String, CodingKey {
            case id, alias, name
            case imageURL = "image_url"
            case isClosed = "is_closed"
            case url
            case reviewCount = "review_count"
            case categories, rating, coordinates, transactions, price, location, phone
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
        let latitude, longitude: Double
    }

    // MARK: - Location
    struct Location: Codable {
        let address1: String
        let address2: Address2?
        let address3: Address3?
        let city: City
        let zipCode: String
        let country: Country
        let state: State
        let displayAddress: [String]

        enum CodingKeys: String, CodingKey {
            case address1, address2, address3, city
            case zipCode = "zip_code"
            case country, state
            case displayAddress = "display_address"
        }
    }

    enum Address2: String, Codable {
        case empty = ""
        case steE = "Ste E"
    }

    enum Address3: String, Codable {
        case empty = ""
        case polkGreenProduceMarket = "Polk & Green Produce Market"
        case the1FerryBldg = "1 Ferry Bldg"
        case theContemporaryJewishMuseum = "The Contemporary Jewish Museum"
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

    enum Price: String, Codable {
        case empty = "$$"
        case price = "$"
    }

    enum Transaction: String, Codable {
        case delivery = "delivery"
        case pickup = "pickup"
    }

    // MARK: - Region
    struct Region: Codable {
        let center: Center
    }
    



