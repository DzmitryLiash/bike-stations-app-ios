//
//  StationInfoEndpoint.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

struct CityBikeInfoEndpoint: Endpoint {
    var path: String {
        "/networks/veturilo-nextbike-warsaw"
    }
    
    typealias responseType = CityBikeInfoDto
}
