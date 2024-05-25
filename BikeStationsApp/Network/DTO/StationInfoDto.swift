//
//  StationInfoDto.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

struct StationInfoDto: Codable {
    let name: String
    let latitude: Double
    let longitude: Double
    let emptySlots: Int
    let freeBikes: Int
    
    enum CodingKeys: String, CodingKey {
        case name, latitude, longitude
        case emptySlots = "empty_slots"
        case freeBikes = "free_bikes"
    }
}
