//
//  SchoolViewModel.swift
//  20230820-KarthikGowda-NYCSchools
//
//  Created by K Madeve Gowda on 20/08/23.
//

import Foundation

class SchoolViewModel {
    
    var highSchools =  [School]()
    
     func fetchHighSchools(completion: @escaping () -> ()) {
        ServiceManager.shared.fetchAllHighSchools { [weak self] result in
            
            switch result {
            case .success(let schools):
                self?.highSchools = schools
                completion()
                
            case .failure(let error):
                print("Error retrieving schools: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchSATScore(schoolId: String, completion: @escaping (SATScore)-> ()) {
        ServiceManager.shared.fetchSATScore(schoolID: schoolId) { results in
            switch results {
            case .success(let satScores):
                completion(satScores)
                
            case .failure(let error):
                print("Error retrieving SAT Scror: \(error.localizedDescription)")
            }
        }
    }
}
