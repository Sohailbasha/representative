//
//  NetworkController.swift
//  Representative3
//
//  Created by Ilias Basha on 9/8/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import Foundation

class NetworkController {
    
    enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case patch = "PATCH"
        case delete = "DELETE"
    }
    
    static func performRequest(for url: URL,
                               httpMethod: HTTPMethod,
                               urlParameters: [String : String]? = nil,
                               body: Data? = nil,
                               completion: ((Data?, Error?) -> Void)? = nil) {
        
        let requestURL = self.url(bbyAdding: urlParameters, to: url)
        var request = URLRequest(url: requestURL)
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion?(data, error)
        }
        dataTask.resume()
    }
    
    static func url(bbyAdding parameters: [String : String]?, to url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters?.flatMap({URLQueryItem(name: $0.0, value: $0.1)})
        
        guard let url = components?.url else {
            fatalError("URL optional is nil")
        }
        return url
    }
}




//    enum HTTPRequest: String {
//        case get = "GET"
//        case put = "PUT"
//        case post = "POST"
//        case delete = "DELETE"
//    }
//
//
//
//    static func performRequest(url: URL,
//                               httpMethod: HTTPRequest,
//                               parameters: [String:String]? = nil,
//                               body: Data? = nil,
//                               completion: ((Data?, Error?) -> Void)? = nil) {
//
//
//        // make request // remember
//        let requestURL = self.urlByAdding(url: url, with: parameters)
//        var request = URLRequest(url: requestURL)
//        request.httpMethod = httpMethod.rawValue
//        request.httpBody = body
//
//
//        // create dataTask
//        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                fatalError("cannot create dataTask from url: \(error)")
//            }
//
//            if let data = data {
//                completion?(data, error)
//            }
//        }
//        // activate dataTask
//        dataTask.resume()
//    }
//
//
//    /// redo this
//    static func urlByAdding(url: URL, with parameters: [String : String]?) -> URL {
//        var components = URLComponents.init(url: url, resolvingAgainstBaseURL: true)
//
//        // remember
//        components?.queryItems = parameters?.flatMap({URLQueryItem(name: $0.0, value: $0.1)})
//
//        // remember
//        guard let url = components?.url else {
//            fatalError("URL optional is nil")
//        }
//
//        return url
//    }
//
//
//
//
//}
//
