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
    
    init(coordinate: CLLocationCoordinate2D, title: String?, isSelected: Bool = false) {
        self.coordinate = coordinate
        self.title = title
        self.isSelected = isSelected
        super.init()
    }
}

class StationAnnotationiew: MKAnnotationView {
    weak var delegate: StationAnnotationDelegate?
    override var annotation: MKAnnotation? {
        willSet {
            guard let customAnnotation = newValue as? StationAnnotation else { return }
            image = customAnnotation.isSelected ? UIImage(named: "Point") : UIImage(named: "SelectedPoint")
            delegate?.stationClicked()
        }
    }
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
         super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
         image = UIImage(named: "SelectedPoint")
         centerOffset = CGPoint(x: 0, y: -image!.size.height / 2)
     }
    
    func setImageForSelection(){
        image = UIImage(named: "Completed")
    }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
     }
}

protocol StationAnnotationDelegate: AnyObject{
    func stationClicked()
}






