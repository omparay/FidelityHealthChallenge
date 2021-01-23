//
//  SearchResult.swift
//  AppFramework
//
//  Created by Oliver Paray on 1/23/21.
//  Model for Search Results
//

import Foundation

public struct SearchResult: Codable {
    public static let dummy =
        SearchResult(malId: 0,
                     url: "",
                     imageUrl: "",
                     title: "Dummy",
                     airing: false,
                     synopsis: "Dummy",
                     type: "Dummy",
                     episodes: 1,
                     score: 0,
                     startDate: Date(),
                     endDate: Date(),
                     members: 0,
                     rated: "G")
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

public struct SearchResults: Codable {
    public static let dummy =
        SearchResults(requestHash: "",
                      requestCached: false,
                      requestCacheExpiry: 32767,
                      results: [SearchResult.dummy],
                      lastPage: 20)
    var requestHash: String
    var requestCached: Bool?
    var requestCacheExpiry: Int?
    var results: [SearchResult]
    var lastPage: Int?
}
