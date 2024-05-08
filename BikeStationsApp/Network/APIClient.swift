//
//  APIClient.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

import Foundation
import Combine

protocol APIClient {
    func fetch<T: Endpoint>(endpoint: T) -> AnyPublisher<T.responseType, Error>
}

extension APIClient {
    func fetch<T: Endpoint>(endpoint: T) -> AnyPublisher<T.responseType, Error>  {
        var urlRequest = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path))
        urlRequest.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach {
            urlRequest.setValue($0.key, forHTTPHeaderField: $0.value)
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .decode(type: T.responseType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
