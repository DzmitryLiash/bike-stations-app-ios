//
//  StationsListViewModel.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

import Foundation
import Combine

class StationsListViewModel {
    
    private let stationsAPIService: StationsAPI
    
    private var cancellables = Set<AnyCancellable>()
    
    init(stationsAPIService: StationsAPI = StationsAPIService()) {
        self.stationsAPIService = stationsAPIService
    }
    
    func loadStations() {
        Publishers.Zip(stationsAPIService.fetchStationInformation(),
                       stationsAPIService.fetchStationStatus())
        .receive(on: RunLoop.main)
        .sink { completion in
            switch completion {
            case let .failure(error):
                print("Couldn't get stations: \(error)")
            case .finished:
                break
            }
        } receiveValue: { (infoStations, statusStations) in
            let stations: [Station] = statusStations.compactMap { statusStation in
                guard let infoStation = infoStations.first(where: { $0.id == statusStation.id }) else {
                    return nil
                }
                return Station(info: infoStation, status: statusStation)
            }
            
            print(stations.first)
        }
        .store(in: &cancellables)
    }
}
