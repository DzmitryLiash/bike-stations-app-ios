//
//  StationStatus.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

struct StationStatus: Hashable {
    let id: String
    let numberBikesAvailable: Int
    let numberDocksAvailable: Int
}

extension StationStatus {
    init(dto: StationStatusDto) {
        self.id = dto.id
        self.numberBikesAvailable = dto.numberBikesAvailable
        self.numberDocksAvailable = dto.numberDocksAvailable
    }
}
