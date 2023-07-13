//
//  LocationManager.swift
//  BusStopsOnMap
//
//  Created by İbrahim Erdogan on 12.07.2023.
//

import Foundation

class StationManager{
    func fetchStations(completion: @escaping (Result<[Station],APIError>) -> ()){
        guard let apiUrl = URL(string: Keys.StationApiLink) else {
            completion(.failure(.badURL))
            return
        }
        fetch(type: [Station].self, url: apiUrl, completion: completion)
    }
    
    func fetch<T : Codable>(type : T.Type ,url : URL? , completion : @escaping (Result<T,APIError>)->Void)
    {
        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as? URLError {
                completion(Result.failure(APIError.urlSession(error)))
            }
            else if let response = response as? HTTPURLResponse,!(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(response.statusCode)))
            }
            if let data = data {
                do{
                   let album = try JSONDecoder().decode(type.self, from: data)
                    completion(Result.success(album))
                    
                }
                catch
                {
                    completion(Result.failure(APIError.decodingError(error as? DecodingError)))
                }
               
               
            }
        }.resume()
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
