//
//  AppError.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 12/05/2024.
//

enum AppError: String, Error {
    case fetchSectionsFailed
    case unknownAuthorizationStatus
    case locationAccessDenied
    case locationUnknown
    case locationErrorUnknown
    
    var localizedDescription: String {
        switch self {
        case .fetchSectionsFailed:
            return "Couldn't get stations. Do you want to try again?"
        case .unknownAuthorizationStatus:
            return "Unknown location authorization status. Please try again later."
        case .locationAccessDenied:
            return "Location access is denied. Please enable location access in the app settings."
        case .locationUnknown:
            return "Unable to determine your current location. Please try again later."
        case .locationErrorUnknown:
            return "An unknown error occurred while fetching your location. Please try again later."
        }
    }
}
