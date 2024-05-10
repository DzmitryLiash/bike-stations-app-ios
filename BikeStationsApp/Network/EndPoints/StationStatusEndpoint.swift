//
//  StationStatusEndpoint.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

struct StationStatusEndpoint: Endpoint {
    var path: String {
        "/station_status.json"
    }
    
    typealias responseType = StationStatusResponseDto
}
