//
//  StationsEndpoints.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

import Foundation

enum StationEndpoints {
    case fetchStationInformation
    case fetchStationStatus
}

extension StationEndpoints: Endpoint {
    var baseURL: URL {
        guard let url = URL(string: "https://gbfs.urbansharing.com/rowermevo.pl") else {
            fatalError("baseURL could not be configured.")
        }
        
        return url
    }
    
    var path: String {
        switch self {
        case .fetchStationInformation:
            return "/station_information.json"
        case .fetchStationStatus:
            return "/station_status.json"
        }
    }
    
    var method: HTTPRequestMethod {
        switch self {
        case .fetchStationInformation:
            return .get
        case .fetchStationStatus:
            return .get
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchStationInformation:
            return nil
        case .fetchStationStatus:
            return nil
        }
    }
}
