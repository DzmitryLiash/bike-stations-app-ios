//
//  StationInfo.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

struct StationInfo: Hashable {
    let id: String
    let name: String
    let address: String
    let crossStreet: String
    let lat: Double
    let lon: Double
}

extension StationInfo {
    init(dto: StationInfoDto) {
        self.id = dto.id
        self.name = dto.name
        self.address = dto.address
        self.crossStreet = dto.crossStreet
        self.lat = dto.lat
        self.lon = dto.lon
    }
}
