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
    func viewModelDidFetchStations(_ viewModel: StationsListViewModel)
    func viewModel(_ viewModel: StationsListViewModel, didOccurr error: AppError)
}

final class StationsListViewModel {
    
    weak var delegate: StationsListViewModelDelegate?
    weak var coordinator: StationsListCoordinatorProtocol?
    
    var stations = [Station]()
    
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
        stationsAPIService.fetchStationInformation()
            .map { [weak self] stationsInfo -> [Station] in
                let stations: [Station] = stationsInfo.map { stationInfo -> Station in
                    let distance = self?.getDistance(latitude: stationInfo.latitude, longitude: stationInfo.longitude)
                    
                    return Station(info: stationInfo, distance: distance)
                }
                
                return stations
            }
            .map { stations in
                stations.sorted { $0.distance ?? 0 < $1.distance ?? 0 }
            }
            .handleEvents(receiveOutput: { stations in
                self.stations = stations
            })
            .convertToResult()
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                guard let self else {
                    return
                }
                
                switch result {
                case .success:
                    delegate?.viewModelDidFetchStations(self)
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
