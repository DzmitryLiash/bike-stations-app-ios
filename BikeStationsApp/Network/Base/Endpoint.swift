//
//  EndPoint.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPRequestMethod { get }
    var headers: [String: String]? { get }
    
    associatedtype responseType: Decodable
}

extension Endpoint {
    var baseURL: URL {
        guard let url = URL(string: "https://api.citybik.es/v2") else {
            fatalError("baseURL could not be configured.")
        }
        
        return url
    }
    
    var method: HTTPRequestMethod {
        .get
    }
    
    var headers: [String : String]? {
        nil
    }
}
