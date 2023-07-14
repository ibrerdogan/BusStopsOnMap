//
//  HomePresenter.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 12.07.2023.
//

import Foundation

protocol HomePresenterDelegate: AnyObject{
    func showStations(_ stations: [Station])
    func showAlert(_ alertText: String )
}

class HomePresenter{
    private let stationManager: StationManager
    weak var delegate: HomePresenterDelegate?
    var selectedStation: Station?
    init(stationManager: StationManager) {
        self.stationManager = stationManager
    }
    
    func getStations()
    {
        stationManager.fetchStations {[weak self] result in
            switch result {
            case .success(let success):
                self?.delegate?.showStations(success)
            case .failure(let failure):
                self?.delegate?.showAlert(failure.localizedDescription)
            }
        }
    }
}
