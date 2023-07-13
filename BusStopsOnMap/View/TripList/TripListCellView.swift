//
//  TripListCellView.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 14.07.2023.
//

import Foundation
import UIKit
class TripListCellView: UITableViewCell {
    static let identifier = "customTableViewCell"
    private lazy var busNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var tripTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var buttonContainer: ButtonContainerView = {
        let container = ButtonContainerView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.clipsToBounds = true
        container.layer.cornerRadius = 15
        return container
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addComponents()
        configureLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents(){
        contentView.addSubview(busNameLabel)
        contentView.addSubview(tripTimeLabel)
        contentView.addSubview(buttonContainer)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            busNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            busNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            buttonContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            buttonContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            buttonContainer.heightAnchor.constraint(equalToConstant: 30),
            buttonContainer.widthAnchor.constraint(equalToConstant: 80),
            
            tripTimeLabel.trailingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: -10),
            tripTimeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    func configureCell(_ busName: String, _ time: String){
        busNameLabel.text = busName
        tripTimeLabel.text = time
        buttonContainer.configureButtonText("Book")
    }
    
}
