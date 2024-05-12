//
//  StationViewViewModel.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 10/05/2024.
//

final class StationViewViewModel {
    
    var title: String {
        "\(station.info.id) \(station.info.name)"
    }
    
    var distance: String {
        guard let distance = station.distance else {
            return ""
        }
        
        if distance > 1000 {
            let kilometers = Int(distance / 1000)
            let meters = Int(distance) % 1000
            
            if meters == 0 {
                return "\(kilometers)km"
            } else {
                return "\(kilometers)km \(meters)m"
            }
        }
        
        return "\(Int(distance))m"
    }
    
    var address: String {
        station.info.address
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
