//
//  StationsListViewModel.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

import Foundation
import Combine
import CoreLocation

protocol StationsListViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: StationsListViewModel, didFetch stations: [Station])
    func viewModel(_ viewModel: StationsListViewModel, didOccurr error: AppError)
}

final class StationsListViewModel {
    
    weak var delegate: StationsListViewModelDelegate?
    weak var coordinator: StationsListCoordinatorProtocol?
    
    private var locationService = LocationService()
    private var cancellables = Set<AnyCancellable>()
    
    private let stationsAPIService: StationsAPI
    private var userLocation: CLLocation?
    
    init(stationsAPIService: StationsAPI = StationsAPIService()) {
        self.stationsAPIService = stationsAPIService
        
        locationService.requestLocationAuthorization()
        locationService.delegate = self
        userLocation = locationService.location
    }
    
    func loadStations() {
        Publishers.Zip(stationsAPIService.fetchStationInformation(),
                       stationsAPIService.fetchStationStatus())
        .map { [weak self] infoStations, statusStations -> [Station] in
            let stations: [Station] = statusStations.compactMap { statusStation in
                guard let infoStation = infoStations.first(where: { $0.id == statusStation.id }) else {
                    return nil
                }
                
                let distance = self?.getDistance(latitude: infoStation.lat, longitude: infoStation.lon)
                
                return Station(info: infoStation, status: statusStation, distance: distance)
            }
            
            return stations
        }
        .map { stations in
            stations.sorted { $0.distance ?? 0 < $1.distance ?? 0 }
        }
        .convertToResult()
        .receive(on: RunLoop.main)
        .sink { [weak self] result in
            guard let self else {
                return
            }
            
            switch result {
            case let .success(stations):
                delegate?.viewModel(self, didFetch: stations)
            case .failure:
                delegate?.viewModel(self, didOccurr: .fetchSectionsFailed)
            }
        }
        .store(in: &cancellables)
    }
    
    func showDetails(for station: Station) {
        coordinator?.showDetails(for: station)
    }
    
    private func getDistance(latitude: Double, longitude: Double) -> Double? {
        guard let userLocation else {
            return nil
        }
        
        let destinationLocation = CLLocation(latitude: latitude, longitude: longitude)
        
        return userLocation.distance(from: destinationLocation)
    }
}

extension StationsListViewModel: LocationServiceDelegate {
    func didUpdateLocation(_ location: CLLocation) {
        userLocation = location
    }
    
    func didFailWithError(_ error: AppError) {
        delegate?.viewModel(self, didOccurr: error)
    }
}
