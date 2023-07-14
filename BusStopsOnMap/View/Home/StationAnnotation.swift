//
//  StationAnnotation.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 13.07.2023.
//

import Foundation
import MapKit
import CoreLocation
class StationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var isSelected: Bool
    var station: Station
    
    init(coordinate: CLLocationCoordinate2D, title: String?, isSelected: Bool = false,station: Station) {
        self.coordinate = coordinate
        self.title = title
        self.isSelected = isSelected
        self.station = station
        super.init()
    }
}



