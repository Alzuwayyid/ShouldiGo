//
//  CountryAutoCompletionJsonResults.swift
//  ShouldiGo
//
//  Created by Mohammed on 23/12/2020.
//

import Foundation


// MARK: - CountryAutoCompletionResult
struct CountryAutoCompletionResult: Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat, lon: Double
    let url: String
}


typealias CountryAutoCompletionResults = [CountryAutoCompletionResult]
