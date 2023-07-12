//
//  LocationManager.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 12.07.2023.
//

import Foundation

class StationManager{
    func getStations(completion : @escaping (Result<[Station],APIError>) -> ())
    {
        guard let apiUrl = URL(string: Keys.StationApiLink) else {
            completion(.failure(.badURL))
            return
        }
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard error == nil else {
                completion(.failure(.urlSession((error as? URLError)!)))
                return
            }
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                let code = response as? HTTPURLResponse
                completion(.failure(.badResponse(code?.statusCode ?? 0)))
                return
            }
            guard let data = data else {
                completion(.failure(.unknown))
                return
            }
            
            do{
                let myArray = try JSONDecoder().decode([Station].self, from: data)
                completion(.success(myArray))
            }
            catch{
                completion(.failure(.unknown))
            }
        }
        .resume()
    }
}
enum APIError : Error , CustomStringConvertible
{
    case badURL
    case urlSession(URLError)
    case badResponse(Int)
    case decodingError(DecodingError?)
    case unknown
    
    var description: String {
        switch self {
        case .badURL:
            return "badURL"
        case .urlSession(let error):
            return "urlSession \(error.localizedDescription)"
        case .badResponse(let statusCode):
            return "badResponse \(statusCode)"
        case .decodingError(let decodingError):
            return "decodingError \(decodingError?.localizedDescription ?? "decoding error")"
        case .unknown:
            return "unknown"
        }
    }
    
    var localizedDescription : String{
        switch self {
        case .badURL:
            return "something went wrong"
        case .urlSession(let uRLError):
            return uRLError.localizedDescription
        case .decodingError(let decodingError):
            return decodingError?.localizedDescription ?? "decoding error"
        case .unknown:
            return "something went wrong"
        case .badResponse(_):
            return "something went wrong"
        }
    }
    
}
