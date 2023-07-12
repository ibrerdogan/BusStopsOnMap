//
//  TripModel.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 12.07.2023.
//

import Foundation
struct Trip: Codable {
    let busName: String
    let id: Int
    let time: String

    enum CodingKeys: String, CodingKey {
        case busName = "bus_name"
        case id, time
    }
}
