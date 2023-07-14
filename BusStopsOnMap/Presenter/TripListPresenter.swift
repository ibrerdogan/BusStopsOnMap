//
//  TripListPresenter.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 13.07.2023.
//

import Foundation
protocol TripPresenterDelegate: AnyObject{
    func bookingSuccess()
    func bookingFailed(_ alertText: String )
}

class TripPresenter{
    private let stationManager: StationManager
    weak var delegate: TripPresenterDelegate?
    init(stationManager: StationManager) {
        self.stationManager = stationManager
    }
    
    func bookToTrip(_ station: Station,tripIndex: Int){
        stationManager.bookTrip(station: String(station.id),
                                trip: String(tripIndex)) { [weak self] result in
            switch result {
            case .success(_):
                self?.delegate?.bookingSuccess()
            case .failure(let failure):
                self?.delegate?.bookingFailed(failure.localizedDescription)
            }
        }
    }
}
