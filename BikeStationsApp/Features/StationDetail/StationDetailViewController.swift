//
//  StationDetailViewController.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 09/05/2024.
//

import UIKit
import MapKit

final class StationDetailViewController: BaseViewController {

    private let mapView = MKMapView()
    private let stationView = StationView()
    
    private enum Constants {
        static let stationViewHeight: CGFloat = 232
        static let stationPointViewHeight: CGFloat = 24
        static let stationPointViewWidth: CGFloat = 46
        static let stationPointViewCornerRadius: CGFloat = 12
        static let mapViewBottomAnchorConstant: CGFloat = 32
        static let coordinateSpanLatitudeDelta: CLLocationDegrees = 0.01
        static let coordinateSpanLongitudeDelta: CLLocationDegrees = 0.01
        static let annotationViewCenterOffsetMultiplier: CGFloat = 2
    }
    
    private let viewModel: StationDetailViewModel
    
    init(viewModel: StationDetailViewModel) {
        self.viewModel = viewModel

        super.init()
    }
        
    override func addSubviews() {
        super.addSubviews()
        
        [mapView, stationView].forEach(view.addSubview)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        view.backgroundColor = .background
        
        mapView.setRegion(viewModel.getCoordinateRegion(), animated: true)
        mapView.delegate = self
        mapView.addAnnotation(viewModel.getAnnotation())
        
        [mapView, stationView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        stationView.load(viewModel.stationViewViewModel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            stationView.heightAnchor.constraint(equalToConstant: Constants.stationViewHeight),
            stationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: stationView.topAnchor, constant: Constants.mapViewBottomAnchorConstant)
        ])
    }
}

extension StationDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? MKPointAnnotation else {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "stationPointAnnotationView")
        
        if annotationView == nil {
            let stationPointView = StationPointView(freeBikesCount: viewModel.freeBikesCount)
            stationPointView.frame = CGRect(x: .zero, y: .zero, width: Constants.stationPointViewWidth, height: Constants.stationPointViewHeight)
            stationPointView.layer.cornerRadius = Constants.stationPointViewCornerRadius
            
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "stationPointAnnotationView")
            annotationView?.addSubview(stationPointView)
            annotationView?.frame = stationPointView.frame
            annotationView?.centerOffset = CGPoint(x: .zero,
                                                   y: -Constants.stationPointViewHeight / Constants.annotationViewCenterOffsetMultiplier)
            annotationView?.isOpaque = false
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
}
