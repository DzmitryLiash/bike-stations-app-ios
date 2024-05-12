//
//  StationsListViewController.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 08/05/2024.
//

import UIKit

final class StationsListViewController: BaseViewController {

    private typealias DataSource = UITableViewDiffableDataSource<Section, Station>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Station>
    
    private lazy var tableView = UITableView()
    private lazy var dataSource = createDataSource()
    
    private enum Section {
        case main
    }
    
    private enum Constants {
        static let tableViewTopAnchorConstant: CGFloat = 20
        static let tableViewHeightForRowConstant: CGFloat = 208
    }
    
    private let viewModel: StationsListViewModel
    
    init(viewModel: StationsListViewModel = StationsListViewModel()) {
        self.viewModel = viewModel
        super.init()
        viewModel.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadStations()
    }
    
    private func createDataSource() -> DataSource {
        DataSource(tableView: tableView) { tableView, indexPath, item in
            guard let cell: StationsListCell = tableView.dequeueReusableCell(withIdentifier: StationsListCell.reuseIdentifier, for: indexPath) as? StationsListCell else {
                
                return UITableViewCell()
            }
            
            cell.setup(with: item)

            return cell
        }
    }
    
    private func setupDataSourceSnapshot() {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.stations)
        dataSource.apply(snapshot)
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        view.addSubview(tableView)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        view.backgroundColor = .background
        tableView.backgroundColor = .background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(StationsListCell.self, forCellReuseIdentifier: StationsListCell.reuseIdentifier)
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.tableViewTopAnchorConstant),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

extension StationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.tableViewHeightForRowConstant
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        viewModel.showDetails(for: item)
    }
}

extension StationsListViewController: StationsListViewModelDelegate {
    func viewModelDidFetchStations(_ viewModel: StationsListViewModel) {
        DispatchQueue.main.async {
            self.setupDataSourceSnapshot()
        }
    }
    
    func viewModel(_ viewModel: StationsListViewModel, didOccurr error: AppError) {
        if error == .fetchSectionsFailed {
            handle(error: error) {
                viewModel.loadStations()
            }
        } else {
            handle(error: error)
        }
    }
}
