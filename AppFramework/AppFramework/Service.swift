//
//  Service.swift
//  AppFramework
//
//  Created by Oliver Paray on 1/23/21.
//

import Foundation
import UIKit

public typealias SearchHandler = (Result<SearchResults,Error>) -> Void
public typealias ImageHandler = (Result<UIImage,Error>) -> Void

public class Service {
    
    //MARK: Properties
    public static let sharedInstance = Service()
    private let decoder = JSONDecoder()
    private let endPoint: String?
    private let transportProtocol: String?
    private let queryStringFormat: String?
    private var searchText: String?
    private var endPointURL: URL? {
        get {
            guard let tp = transportProtocol,
                  let ep = endPoint,
                  let query = queryStringFormat,
                  let text = searchText
            else { return nil }
            let initial = tp.appending(ep).appending(String(format: query, text))
            return URL(string: initial)
        }
    }
    
    //MARK: Initializers
    public init() {
        self.endPoint = "api.jikan.moe/v3/search/anime"
        self.transportProtocol = "https://"
        self.queryStringFormat = "?q=%@"
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder.dateDecodingStrategy = .iso8601
    }
    
    public init(endPoint: String, transportProtocol: String, queryStringFormat: String) {
        self.endPoint = endPoint
        self.transportProtocol = transportProtocol
        self.queryStringFormat = queryStringFormat
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder.dateDecodingStrategy = .iso8601
    }
    
    //MARK: Class Methods
    public func search(text: String, handler: @escaping SearchHandler) {
        self.searchText = text
        guard let searchUrl = self.endPointURL else {
            handler(.failure(HttpClientError.badUrl))
            return
        }
        HTTPClient.sharedInstance.request(url: searchUrl, method: Method.Get) { (result) in
            switch result {
            case .success(let data):
                do {
                    let results = try self.decoder.decode(SearchResults.self, from: data)
                    handler(.success(results))
                } catch {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    public func getImage(urlString: String, handler: @escaping ImageHandler) {
        guard let imageUrl = URL(string: urlString) else {
            handler(.failure(HttpClientError.badUrl))
            return
        }
        HTTPClient.sharedInstance.request(url: imageUrl, method: Method.Get) { (result) in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else {
                    handler(.failure(HttpClientError.noData))
                    return
                }
                handler(.success(image))
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    //MARK: Public Methods

    
    //MARK: Delegates


    //MARK: Datasource


    //MARK: Handlers

}
