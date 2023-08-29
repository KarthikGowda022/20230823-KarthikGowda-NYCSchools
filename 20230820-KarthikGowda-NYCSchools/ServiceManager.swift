//
//  ServiceManager.swift
//  20230820-KarthikGowda-NYCSchools
//
//  Created by K Madeve Gowda on 20/08/23.
//

import Foundation


enum NetworkErrors: Error {
    case invalidUrl
    case parsingError
}

class ServiceManager {
    
    static let shared = ServiceManager()
    
    
    func fetchAllHighSchools(_ completionHandler: @escaping (Result<[School], Error>) -> Void) {
        
        let url = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
        
        guard let fetchUrl = URL(string: url) else {
            completionHandler(.failure(NetworkErrors.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: fetchUrl) { (data, response, error) in
            
            if (error != nil) {
                completionHandler(.failure(error!))
            }
            else if let schoolData = data {
                do {
                    let result =  try JSONDecoder().decode([School].self, from: schoolData)
                    completionHandler(.success(result))
                }
                catch {
                    completionHandler(.failure(error))
                }
            }
        }.resume()
    }
    
    func fetchSATScore(schoolID: String, completion: @escaping (Result<SATScore, Error>) -> ()) {
        
        let baseUrl = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
        let completeUrl = baseUrl + "?dbn=\(schoolID)"
        guard let getSatScoreURl = URL(string: completeUrl) else { return completion(.failure(NetworkErrors.invalidUrl)) }
        
        URLSession.shared.dataTask(with: getSatScoreURl) { data, httpresponse, error in
            
            if error != nil {
                completion(.failure(error!))
            }
            else if let SATData = data {
                do {
                    
                    let SATScoreList = try JSONDecoder().decode([SATScore].self, from: SATData)
                    if let satScore = SATScoreList.first {
                        completion(.success(satScore))
                    }
                    
                } catch {
                    completion(.failure(NetworkErrors.parsingError))
                }
            }
        }.resume()
    }
    
}

