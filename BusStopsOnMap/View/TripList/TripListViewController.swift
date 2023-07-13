//
//  TripListViewController.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 13.07.2023.
//

import UIKit

class TripListViewController: UIViewController {
    let station: Station
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    init(station: Station) {
        self.station = station
        super.init(nibName: nil, bundle: nil)
        for i in station.trips{
            print(i.busName)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
