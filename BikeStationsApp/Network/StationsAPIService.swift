//
//  StationsAPIService.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

import Combine

protocol StationsAPI: APIClient {
    func fetchStationInformation() -> AnyPublisher<[StationInfo], Error>
    func fetchStationStatus() -> AnyPublisher<[StationStatus], Error>
}

struct StationsAPIService: StationsAPI {
    func fetchStationInformation() -> AnyPublisher<[StationInfo], Error> {
        return fetch(endpoint: StationInfoEndpoint())
            .map { info in
                info.data.stations.map(StationInfo.init)
            }
            .eraseToAnyPublisher()
    }
    
    func fetchStationStatus() -> AnyPublisher<[StationStatus], Error> {
        return fetch(endpoint: StationStatusEndpoint())
            .map { status in
                status.data.stations.map(StationStatus.init)
            }
            .eraseToAnyPublisher()
    }
}
