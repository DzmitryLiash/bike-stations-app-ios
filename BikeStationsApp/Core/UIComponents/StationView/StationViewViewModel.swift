//
//  StationViewViewModel.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 10/05/2024.
//

final class StationViewViewModel {
    
    var title: String {
        "\(station.info.id) \(station.info.address)"
    }
    
    var subtitle: String {
        "500m • \(station.info.name)"
    }
    
    var bikesAvailableCount: String {
        String(station.status.numberBikesAvailable)
    }
    
    var docksAvailableCount: String {
        String(station.status.numberDocksAvailable)
    }
    
    private let station: Station
    
    init(station: Station) {
        self.station = station
    }
}
