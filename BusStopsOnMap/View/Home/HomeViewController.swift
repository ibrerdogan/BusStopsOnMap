//
//  ViewController.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 12.07.2023.
//

import UIKit
import MapKit
import CoreLocation
class HomeViewController: UIViewController {

    let presenter = HomePresenter(stationManager: StationManager())
    let locationManager = CLLocationManager()
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.isZoomEnabled = true
        mapView.isRotateEnabled = true
        return mapView
    }()
    private lazy var buttonContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.layer.cornerRadius = 30
        container.backgroundColor = .blue
        container.isHidden = true
        return container
    }()
    private lazy var buttonLabel: UILabel = {
        let buttonLabel = UILabel()
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonLabel.text = "List Trips"
        buttonLabel.textColor = .white
        return buttonLabel
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
        configureView()
        configureDelegates()
        presenter.getStations()
        askLocationPermission()
    }
    
    private func configureDelegates(){
        presenter.delegate = self
        locationManager.delegate = self
        mapView.delegate = self
    }
    
    private func addComponents(){
        view.addSubview(mapView)
        view.addSubview(buttonContainer)
        buttonContainer.addSubview(buttonLabel)
    }
    
    private func configureView(){
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            buttonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            buttonContainer.heightAnchor.constraint(equalToConstant: 60),
            
            buttonLabel.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor),
            buttonLabel.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
            
        ])
    }
    private func askLocationPermission(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    private func centerMap(_ region: MKCoordinateRegion){
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {[weak self] in
            self?.mapView.setRegion(region, animated: true)
            self?.locationManager.stopUpdatingLocation()
        }
    }
    
}

extension HomeViewController: HomePresenterDelegate{
    func showStations(_ stations: [Station]) {
        for station in stations {
            if let coordinate = station.centerCoordinates.coordinates(){
               let stationLocation = StationAnnotation(coordinate: CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude),
                                                       title: station.name)
                mapView.addAnnotation(stationLocation)
            }
        }
        mapView.showAnnotations(mapView.annotations, animated: true)
        mapView.showsUserLocation = true
    }
    
    func showAlert(_ alertText: String) {
        
    }
}

extension HomeViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           if let location = locations.last {
               let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
               centerMap(region)
           }
       }
}

extension HomeViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let stationAnnotation = annotation as? StationAnnotation else {return nil}
        let view = StationAnnotationiew(annotation: stationAnnotation, reuseIdentifier: "pin")
        view.canShowCallout = false
        return view
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let annotation = view as? StationAnnotationiew{
            annotation.setImageForSelection()
            buttonContainer.isHidden = false
        }
    }
}
