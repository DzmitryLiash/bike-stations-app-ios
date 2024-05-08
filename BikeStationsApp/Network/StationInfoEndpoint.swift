//
//  StationInfoEndpoint.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

struct StationInfoEndpoint: Endpoint {
    var path: String {
        "/station_information.json"
    }
    
    typealias responseType = StationInfoResponseDto
}
