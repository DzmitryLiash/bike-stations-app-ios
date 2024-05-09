//
//  StationStatusView.swift
//  BikeStationsApp
//
//  Created by Dzmitry Liashchou on 09/05/2024.
//

import UIKit

enum StationStatusViewType {
    case bikes
    case places
}

class StationStatusView: BaseView {
        
    var number: Int = 0 {
        didSet {
            numberLabel.text = String(number)
        }
    }
    
    private let stackView = UIStackView()
    private let imageView = UIImageView()
    private let numberLabel = UILabel()
    private let textLabel = UILabel()
    
    private var type: StationStatusViewType
    
    init(type: StationStatusViewType) {
        self.type = type
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func addSubviews() {
        super.addSubviews()
        
        addSubview(stackView)
        
        [imageView,
         numberLabel,
         textLabel].forEach(stackView.addArrangedSubview)
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        [stackView,
         imageView,
         numberLabel,
         textLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        stackView.axis = .vertical
        stackView.alignment = .center
        
        numberLabel.text = String(number)
        numberLabel.font = .systemFont(ofSize: 44, weight: .semibold)
        
        textLabel.font = .systemFont(ofSize: 12)
        
        switch type {
        case .bikes:
            imageView.image = .bike
            numberLabel.textColor = .positive
            textLabel.text = "Bikes available"
        case .places:
            imageView.image = .lock
            textLabel.text = "Places available"
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.widthAnchor.constraint(equalToConstant: 24),
            
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

