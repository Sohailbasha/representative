//
//  RepController.swift
//  Representative3
//
//  Created by Ilias Basha on 9/8/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import Foundation

class RepController {
    
    private static let baseURL = "https://whoismyrepresentative.com/getall_reps_bystate.php"
    
    static func getDataFor(state: String, completion: @escaping ([Representative]?) -> Void) {

        let urlParameters = ["state":"\(state)", "output":"json"]
        
        if let url = URL(string: baseURL) {
            NetworkController.performRequest(url: url, httpMethod: .get, parameters: urlParameters, completion: { (data, error) in
                
                // unwrap data
                guard let data = data else {
                    completion([])
                    return
                }
                
                // serialize data by turning it into a json Object
                guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]) else {
                    completion([])
                    return
                }
                
                // create jsonDictionaries
                guard let representativeDictionaries = jsonDictionary?["results"] as? [[String:Any]] else {
                    print("unable to serialize json")
                    completion([])
                    return
                }
                
                // create objects from dictionaries
                let representatives = representativeDictionaries.flatMap { Representative(dictionary: $0) }
                
                // completion
                completion(representatives)
            })
        }
    }
    
}
