//
//  ButtonContainerView.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 14.07.2023.
//

import UIKit

class ButtonContainerView: UIView {

    private lazy var buttonContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .blue
        container.isUserInteractionEnabled = true
        return container
    }()
    private lazy var buttonLabel: UILabel = {
        let buttonLabel = UILabel()
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel.text = "List Trips"
        buttonLabel.textColor = .white
        return buttonLabel
    }()
    
    init() {
        super.init(frame: .zero)
        self.addComponents()
        self.configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func addComponents(){
        addSubview(buttonContainer)
        buttonContainer.addSubview(buttonLabel)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            buttonContainer.topAnchor.constraint(equalTo: topAnchor),
            buttonContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            buttonContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            buttonContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            buttonLabel.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            buttonLabel.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
        ])
    }
    func configureButtonText(_ buttonText: String){
        buttonLabel.text = buttonText
    }
    

}
