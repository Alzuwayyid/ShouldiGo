//
//  AutoCompleteJsonResults.swift
//  ShouldiGo
//
//  Created by Mohammed on 19/12/2020.
//

import Foundation

// MARK: - AutoCompleteResults
struct AutoCompleteResults: Codable {
  let categories: [Category]
  let terms: [Term]
}
// MARK: - Term
struct Term: Codable {
  let text: String
}

