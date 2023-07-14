//
//  ErrorPopup.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 14.07.2023.
//

import Foundation
import UIKit

protocol ErrorPopupViewDelegate: AnyObject{
    func dismisView()
}
class ErrorPopupviewController: UIViewController {
    var buttonRecognizer: UITapGestureRecognizer?
    weak var delegate: ErrorPopupViewDelegate?
    private lazy var errorTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var errorSubTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var errorButtonView: ButtonContainerView = {
        let view = ButtonContainerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addComponents()
        configureLayout()
        configureGesture()
    }
    
    func configure(_ title: String, _ subTitle: String,_ buttonText: String){
        errorTitleLabel.text = title
        errorSubTitleLabel.text = subTitle
        errorButtonView.configureButtonText(buttonText)
    }
    private func configureGesture(){
        buttonRecognizer = UITapGestureRecognizer(target: self, action: #selector(centeredButtonClicked))
        errorButtonView.addGestureRecognizer(buttonRecognizer!)
    }
    
    private func addComponents(){
        view.addSubview(errorTitleLabel)
        view.addSubview(errorSubTitleLabel)
        view.addSubview(errorButtonView)
    }
    private func configureLayout(){
        NSLayoutConstraint.activate([
            errorTitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            errorTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            errorTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            errorSubTitleLabel.topAnchor.constraint(equalTo: errorTitleLabel.bottomAnchor, constant: 5),
            errorSubTitleLabel.leadingAnchor.constraint(equalTo: errorTitleLabel.leadingAnchor),
            errorSubTitleLabel.trailingAnchor.constraint(equalTo: errorTitleLabel.trailingAnchor),
            
            errorButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            errorButtonView.leadingAnchor.constraint(equalTo: errorTitleLabel.leadingAnchor),
            errorButtonView.trailingAnchor.constraint(equalTo: errorTitleLabel.trailingAnchor),
            errorButtonView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    @objc private func centeredButtonClicked(){
        delegate?.dismisView()
    }
}
