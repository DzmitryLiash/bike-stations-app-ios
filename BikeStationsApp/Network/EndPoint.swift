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
}
