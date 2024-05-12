//
//  AppCoordinator.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 10/05/2024.
//

import UIKit

protocol AppCoordinatorProtocol {
    func start()
}

protocol StationsListCoordinatorProtocol: AnyObject {
    func showDetails(for station: Station)
}

final class AppCoordinator: AppCoordinatorProtocol {
    private let window: UIWindow
    private var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewModel = StationsListViewModel()
        viewModel.coordinator = self
        
        let stationsListViewController = StationsListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: stationsListViewController)
        
        self.navigationController = navigationController
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: StationsListCoordinatorProtocol {
    func showDetails(for station: Station) {
        let detailViewModel = StationDetailViewModel(station: station)
        let detailViewController = StationDetailViewController(viewModel: detailViewModel)
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
