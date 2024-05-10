//
//  StationsListViewModel.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

import Foundation
import Combine

protocol StationsListViewModelDelegate: AnyObject {
    func viewModel(_ viewModel: StationsListViewModel, didFetch stations: [Station])
}

final class StationsListViewModel {
    
    weak var delegate: StationsListViewModelDelegate?
        
    private var cancellables = Set<AnyCancellable>()
    
    private let stationsAPIService: StationsAPI
    
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
        } receiveValue: { [weak self] (infoStations, statusStations) in
            guard let self else {
                return
            }
            
            let stations: [Station] = statusStations.compactMap { statusStation in
                guard let infoStation = infoStations.first(where: { $0.id == statusStation.id }) else {
                    return nil
                }
                
                return Station(info: infoStation, status: statusStation)
            }
            
            delegate?.viewModel(self, didFetch: stations)
        }
        .store(in: &cancellables)
    }
}
