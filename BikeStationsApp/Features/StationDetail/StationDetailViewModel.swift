//
//  StationDetailViewModel.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 09/05/2024.
//

import Foundation
import MapKit

final class StationDetailViewModel {
    
    let stationViewViewModel: StationViewViewModel
    
    var freeBikesCount: Int {
        station.info.freeBikes
    }
    
    private enum Constants {
        static let coordinateSpanLatitudeDelta: CLLocationDegrees = 0.01
        static let coordinateSpanLongitudeDelta: CLLocationDegrees = 0.01
    }
    
    private let station: Station
    
    init(station: Station) {
        self.station = station
        self.stationViewViewModel = StationViewViewModel(station: station)
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
        CLLocationCoordinate2D(latitude: station.info.latitude, longitude: station.info.longitude)
    }
    
    private func getCoordinateSpan() -> MKCoordinateSpan {
        MKCoordinateSpan(latitudeDelta: Constants.coordinateSpanLatitudeDelta,
                         longitudeDelta: Constants.coordinateSpanLongitudeDelta)
    }
}
