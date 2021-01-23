//
//  SearchResult.swift
//  AppFramework
//
//  Created by Oliver Paray on 1/23/21.
//

import Foundation

struct SearchResult: Codable {
    var malId: Int
    var url: String?
    var imageUrl: String?
    var title: String?
    var airing: Bool?
    var synopsis: String?
    var type: String?
    var episodes: Int?
    var score: Float?
    var startDate: Date?
    var endDate: Date?
    var members: Int?
    var rated: String?
}

struct SearchResults: Codable {
    var requestHash: String
    var requestCached: Bool?
    var requestCacheExpiry: Int?
    var results: [SearchResult]
    var lastPage: Int?
}
