//
//  PublisherExtension.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 12/05/2024.
//

import Combine

extension Publisher {
    func convertToResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self.map(Result.success)
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
}
