//
//  Extensions.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 12.07.2023.
//

import Foundation

extension String {
    func coordinates() -> (latitude: Double, longitude: Double)? {
        let coordinates = self.components(separatedBy: ",")
            .compactMap { component -> Double? in
                return Double(component.trimmingCharacters(in: .whitespaces))
            }
        
        guard coordinates.count == 2 else {
            return nil
        }
        
        return (latitude: coordinates[0], longitude: coordinates[1])
    }
}
