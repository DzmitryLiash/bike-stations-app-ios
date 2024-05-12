//
//  StationViewViewModel.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 10/05/2024.
//

import UIKit

final class StationViewViewModel {
    
    private enum Constants {
      
        static let subtitleLabelFontSize: CGFloat = 12
        
    }
    
    var title: String {
        "\(station.info.id) \(station.info.name)"
    }
    
    var subtitle: NSMutableAttributedString {
        let distance = getDistance()
        let distanceAttributedString = NSMutableAttributedString(string: distance)
        let address = distance.isEmpty ? station.info.address : " • \(station.info.address)"
        let addressAttributedString = NSMutableAttributedString(string: address)
        
        distanceAttributedString.addAttribute(.font,
                                              value: UIFont(name: Fonts.manropeBold,
                                                            size: Constants.subtitleLabelFontSize) ?? UIFont.boldSystemFont(ofSize: Constants.subtitleLabelFontSize),
                                              range: NSRange(location: 0, length: distance.count))
        addressAttributedString.addAttribute(.font,
                                             value: UIFont(name: Fonts.manropeMedium, size: Constants.subtitleLabelFontSize) ?? UIFont.systemFont(ofSize: Constants.subtitleLabelFontSize, weight: .medium),
                                             range: NSRange(location: 0, length: address.count))
        
        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(distanceAttributedString)
        combinedAttributedString.append(addressAttributedString)

        return combinedAttributedString
    }
    
    var bikesAvailableCount: String {
        String(station.status.numberBikesAvailable)
    }
    
    var docksAvailableCount: String {
        String(station.status.numberDocksAvailable)
    }
    
    private let station: Station
    
    init(station: Station) {
        self.station = station
    }
    
    private func getDistance() -> String {
        guard let distance = station.distance else {
            return ""
        }
        
        if distance > 1000 {
            let kilometers = Int(distance / 1000)
            let meters = Int(distance) % 1000
            
            if meters == 0 {
                return "\(kilometers)km"
            } else {
                return "\(kilometers)km \(meters)m"
            }
        }
        
        return "\(Int(distance))m"
    }
}
