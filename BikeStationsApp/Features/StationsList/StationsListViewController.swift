//
//  ViewController.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

import UIKit

class StationsListViewController: UIViewController {

    private let viewModel: StationsListViewModel
    private var stations = [Station]() {
        didSet {

        }
    }
    
    init(viewModel: StationsListViewModel = StationsListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadStations()
    }
}

extension StationsListViewController: StationsListViewModelDelegate {
    func viewModel(_ viewModel: StationsListViewModel, didFetch stations: [Station]) {
        self.stations = stations
    }
}
