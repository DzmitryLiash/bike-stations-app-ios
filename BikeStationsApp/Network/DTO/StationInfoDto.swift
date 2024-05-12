//
//  StationInfoDto.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

struct StationInfoDto: Codable {
    let id: String
    let name: String
    let address: String
    let crossStreet: String
    let lat: Double
    let lon: Double
    
    enum CodingKeys: String, CodingKey {
        case id = "station_id"
        case name, address, lat, lon
        case crossStreet = "cross_street"
    }
}
