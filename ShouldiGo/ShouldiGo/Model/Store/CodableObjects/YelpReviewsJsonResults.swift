//
//  YelpReviewsJsonResults.swift
//  ShouldiGo
//
//  Created by Mohammed on 21/12/2020.
//

import Foundation

// MARK: - YelpReviewsResult
struct YelpReviewsResult: Codable {
    let reviews: [Review]
    
    enum CodingKeys: String, CodingKey {
        case reviews
    }
}

// MARK: - Review
struct Review: Codable {
    let id: String
    let url: String
    let text: String
    let rating: Int
    let timeCreated: String
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id, url, text, rating
        case timeCreated = "time_created"
        case user
    }
}

// MARK: - User
struct User: Codable {
    let id: String?
    let profileURL: URL?
    let imageURL: URL?
    let name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case profileURL = "profile_url"
        case imageURL = "image_url"
        case name
    }
}
