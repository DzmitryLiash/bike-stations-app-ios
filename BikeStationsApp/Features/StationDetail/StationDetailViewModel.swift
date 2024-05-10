//
//  StationDetailViewModel.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 09/05/2024.
//

import Foundation
import MapKit

final class StationDetailViewModel {
    
    let station: Station
    
    var numberBikesAvailable: Int {
        station.status.numberBikesAvailable
    }
    
    private enum Constants {
        static let coordinateSpanLatitudeDelta: CLLocationDegrees = 0.01
        static let coordinateSpanLongitudeDelta: CLLocationDegrees = 0.01
    }
    
    init(station: Station) {
        self.station = station
    }
    
    func getAnnotation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = getCoordinate()
        
        return annotation
    }
    
    func getCoordinateRegion() -> MKCoordinateRegion {
        MKCoordinateRegion(center: getCoordinate(), span: getCoordinateSpan())
    }
    
    private func getCoordinate() -> CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: station.info.lat, longitude: station.info.lon)
    }
    
    private func getCoordinateSpan() -> MKCoordinateSpan {
        MKCoordinateSpan(latitudeDelta: Constants.coordinateSpanLatitudeDelta,
                         longitudeDelta: Constants.coordinateSpanLongitudeDelta)
    }
}
