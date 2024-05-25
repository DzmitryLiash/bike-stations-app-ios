//
//  StationViewViewModel.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 10/05/2024.
//

final class StationViewViewModel {
    
    var title: String {
        station.info.name
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
    
    var freeBikesCount: String {
        String(station.info.freeBikes)
    }
    
    var emptySlotsCount: String {
        String(station.info.emptySlots)
    }
    
    private let station: Station
    
    init(station: Station) {
        self.station = station
    }
}
