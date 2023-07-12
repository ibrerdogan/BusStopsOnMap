//
//  ViewController.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 12.07.2023.
//

import UIKit
import MapKit
class HomeViewController: UIViewController {

    let presenter = HomePresenter(stationManager: StationManager())
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isZoomEnabled = true
        mapView.isRotateEnabled = true
        return mapView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
        configureView()
        presenter.getStations()
    }
    
    private func addComponents(){
        view.addSubview(mapView)
    }
    
    private func configureView(){
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}
extension HomeViewController: HomePresenterDelegate{
    func showStations(_ stations: [Station]) {
        
    }
    
    func showAlert(_ alertText: String) {
        
    }
    
    
}
