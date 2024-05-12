//
//  BaseViewController.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 09/05/2024.
//

import UIKit

class BaseViewController: UIViewController {
        
    @available(*, unavailable, message: "init(nibName: , bundle: ) has not been implemented")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
   
    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTopBar()
        addSubviews()
        setupConstraints()
        setupSubviews()
    }
    
    func setupTopBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .navigationBarBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.setBackIndicatorImage(.back, transitionMaskImage: .back)
    
        navigationItem.backButtonTitle = ""
    
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func addSubviews() {}
    
    func setupConstraints() {}
    
    func setupSubviews() {}
    
    func handle(error: Error, retryAction: @escaping () -> Void) {
        if let appError = error as? AppError {
            switch appError {
            case .fetchSectionsFailed:
                showAlert(message: appError.localizedDescription, retryAction: retryAction)
            case .unknownAuthorizationStatus:
                showAlert(message: appError.localizedDescription)
            case .locationAccessDenied:
                showAlert(message: appError.localizedDescription)
            case .locationUnknown:
                showAlert(message: appError.localizedDescription)
            case .locationErrorUnknown:
                showAlert(message: appError.localizedDescription)
            }
        } else {
            showAlert(message: "An unknown error occurred. Please try again later.")
        }
    }
    
    private func showAlert(message: String, retryAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        if let retryAction = retryAction {
            alert.addAction(UIAlertAction(title: "Retry", style: .default) { _ in
                retryAction()
            })
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        } else {
            alert.addAction(UIAlertAction(title: "OK", style: .default))
        }
        
        present(alert, animated: true)
    }
}
