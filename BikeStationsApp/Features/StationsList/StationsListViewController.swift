//
//  ViewController.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

import UIKit

class StationsListViewController: UIViewController {

    private let viewModel: StationsListViewModel
    
    init(viewModel: StationsListViewModel = StationsListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadStations()
    }
}

