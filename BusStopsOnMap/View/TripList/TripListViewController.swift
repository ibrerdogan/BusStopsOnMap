//
//  TripListViewController.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 13.07.2023.
//

import UIKit

class TripListViewController: UIViewController {
    let station: Station
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TripListCellView.self, forCellReuseIdentifier: TripListCellView.identifier)
        tableView.estimatedRowHeight = 100
        tableView.allowsSelection = false
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }
    init(station: Station) {
        self.station = station
        super.init(nibName: nil, bundle: nil)
        configureDelegates()
        addComponents()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addComponents(){
        view.addSubview(mainTableView)
    }
    private func configureDelegates(){
        mainTableView.delegate = self
        mainTableView.dataSource = self
    }
    private func configureLayout(){
        NSLayoutConstraint.activate([
            mainTableView.topAnchor.constraint(equalTo: view.topAnchor),
            mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension TripListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return station.tripsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: TripListCellView.identifier, for: indexPath) as? TripListCellView
        cell?.configureCell(station.trips[indexPath.row].busName, station.trips[indexPath.row].time)
        return cell!
    }
    
    
}
