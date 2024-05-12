//
//  StationStatusDto.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

struct StationStatusDto: Codable {
    let id: String
    let numberBikesAvailable: Int
    let numberDocksAvailable: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "station_id"
        case numberBikesAvailable = "num_bikes_available"
        case numberDocksAvailable = "num_docks_available"
    }
}
