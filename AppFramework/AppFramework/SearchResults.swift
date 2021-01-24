//
//  SearchResults.swift
//  AppFramework
//
//  Created by Oliver Paray on 1/23/21.
//  Model for Search Results
//

import Foundation

public struct SearchResults: Codable {
    public static let dummy =
        SearchResults(requestHash: "",
                      requestCached: false,
                      requestCacheExpiry: 32767,
                      results: [SearchResult.dummy,
                                SearchResult.dummy,
                                SearchResult.dummy],
                      lastPage: 20)
    public static let empty =
        SearchResults(requestHash: "",
                      requestCached: nil,
                      requestCacheExpiry: nil,
                      results: [],
                      lastPage: nil)
    public var requestHash: String
    public var requestCached: Bool?
    public var requestCacheExpiry: Int?
    public var results: [SearchResult]
    public var lastPage: Int?
}

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
    public var malId: Int
    public var url: String?
    public var imageUrl: String?
    public var title: String?
    public var airing: Bool?
    public var synopsis: String?
    public var type: String?
    public var episodes: Int?
    public var score: Float?
    public var startDate: Date?
    public var endDate: Date?
    public var members: Int?
    public var rated: String?
}
