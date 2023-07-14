//
//  StationCustomAnnotationView.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 13.07.2023.
//

import Foundation
import MapKit
class StationCustomAnnotationView: MKAnnotationView{
    var Station: Station?
    private lazy var stationPinImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Point")
        return imageView
    }()
    convenience init(stationAnnotation: StationAnnotation,station: Station) {
        self.init(annotation: stationAnnotation, reuseIdentifier: "pin")
        self.Station = station
        image = UIImage(named: "Point")
        centerOffset = CGPoint(x: 0, y: -image!.size.height / 2)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        image = UIImage(named: "SelectedPoint")
    }
}
