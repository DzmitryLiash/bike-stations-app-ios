//
//  ReuseIdentifier.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 09/05/2024.
//

import UIKit

public protocol ReuseIdentifier {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReuseIdentifier {
    public static var reuseIdentifier: String {
        String(describing: self)
    }
}
