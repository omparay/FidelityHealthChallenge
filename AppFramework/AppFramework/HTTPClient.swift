//
//  HttpClient.swift
//
//  Created by Oliver Paray on 4/4/2020.
//  Simple HTTP Client without multi-part-form support
//

import CoreFoundation
import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public typealias Header = [String: String]
public typealias ExecutionBlock = (Result<Data, Error>) -> Void

public enum Method:String{
    case Delete,Get,Post,Put
}

public enum HttpClientError: Error{
    case badUrl, noData, stringEncoding

    public var localizedDescription: String{
        switch self{
            case .badUrl:
            return "Malformed URL string"
            case .noData:
            return "No response data"
            case .stringEncoding:
            return "String could not be encoded"
        }
    }
}

public class HTTPClient{

//MARK: Properties
    public static let sharedInstance = HTTPClient()

//MARK: Initializers
    public init() {
        
    }

//MARK: Class Methods


//MARK: Public Methods
    public func request(async concurrent: Bool = true,
                        url: URL,
                        method: Method,
                        header: Header? = nil,
                        bodyData: Data? = nil,
                        queue: DispatchQueue = DispatchQueue.global(qos: .utility),
                        handler: @escaping ExecutionBlock){
        var dataRequest = URLRequest(url: url)
        dataRequest.httpMethod = method.rawValue
        if let headerData = header{
            for (key, value) in headerData{
                dataRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        if let bodyData = bodyData{
            dataRequest.httpBody = bodyData
        }
        if concurrent{
            queue.async{
                self.requestExecution(request: dataRequest, handler: handler)
            }
        } else {
            queue.sync {
                self.requestExecution(request: dataRequest, handler: handler)
            }
        }
    }

    public func request(async concurrent: Bool = true,
                        urlString: String,
                        method: Method,
                        header: Header? = nil,
                        bodyContent: String? = nil,
                        queue: DispatchQueue = DispatchQueue.global(qos: .utility),
                        handler: @escaping ExecutionBlock){
        var data: Data?
        guard let url = URL(string: urlString) else {
            handler(.failure(HttpClientError.badUrl))
            return
        }
        if let body = bodyContent{
            guard let bodyData = body.data(using: .utf8) else {
                handler(.failure(HttpClientError.stringEncoding))
                return
            }
            data = bodyData
        }
        request(async: concurrent, url: url, method: method, header: header, bodyData: data, queue: queue, handler: handler)
    }

    public func request(async concurrent: Bool = true,
                        urlSpec: URL,
                        method: Method,
                        header: Header? = nil,
                        bodyData: Data? = nil,
                        queue: DispatchQueue = DispatchQueue.global(qos: .utility),
                        handler: @escaping ExecutionBlock){
        request(async: concurrent, url: urlSpec, method: method, header: header, bodyData: bodyData, queue: queue, handler: handler)
    }

//MARK: Private Methods
    fileprivate func requestExecution(request: URLRequest,
                                      handler: @escaping ExecutionBlock){
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (responseData, responseStatus, responseError) in
            if let errorOcurred = responseError{
                handler(.failure(errorOcurred))
                return
            }
            guard let returnedData = responseData else {
                handler(.failure(HttpClientError.noData))
                return
            }
            handler(.success(returnedData))
        })
        task.resume()
    }

//MARK: Delegates


//MARK: Datasource


//MARK: Handlers


}
