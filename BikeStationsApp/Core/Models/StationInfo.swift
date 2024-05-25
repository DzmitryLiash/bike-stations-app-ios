//
//  StationInfo.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

struct StationInfo: Hashable {
    let name: String
    let latitude: Double
    let longitude: Double
    let emptySlots: Int
    let freeBikes: Int
}

extension StationInfo {
    init(dto: StationInfoDto) {
        self.name = dto.name
        self.latitude = dto.latitude
        self.longitude = dto.longitude
        self.emptySlots = dto.emptySlots
        self.freeBikes = dto.freeBikes
    }
}
