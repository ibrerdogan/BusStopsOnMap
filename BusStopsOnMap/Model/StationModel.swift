//
//  StationModel.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 12.07.2023.
//

import Foundation
struct Station: Codable{
    let centerCoordinates: String
      let id: Int
      let name: String
      let trips: [Trip]
      let tripsCount: Int

      enum CodingKeys: String, CodingKey {
          case centerCoordinates = "center_coordinates"
          case id, name, trips
          case tripsCount = "trips_count"
      }
}
