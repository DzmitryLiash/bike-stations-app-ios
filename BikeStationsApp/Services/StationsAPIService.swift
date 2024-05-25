//
//  StationsAPIService.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

import Combine

protocol StationsAPI: APIClient {
    func fetchStationInformation() -> AnyPublisher<[StationInfo], Error>
}

struct StationsAPIService: StationsAPI {
    func fetchStationInformation() -> AnyPublisher<[StationInfo], Error> {
        fetch(endpoint: CityBikeInfoEndpoint())
            .map { info in
                info.network.stations.map(StationInfo.init)
            }
            .eraseToAnyPublisher()
    }
}
