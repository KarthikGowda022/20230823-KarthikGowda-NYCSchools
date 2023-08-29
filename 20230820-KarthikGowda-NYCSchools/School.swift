//
//  School.swift
//  20230820-KarthikGowda-NYCSchools
//
//  Created by K Madeve Gowda on 20/08/23.
//

import UIKit

struct School: Decodable {
    
    var dbn: String
    var name: String?
    var location: String?
    var phone: String?
    var email: String?
    var website: String?
    
    var satScore: SATScore?
    
    enum CodingKeys: String, CodingKey {
        case dbn = "dbn"
        case name = "school_name"
        case location = "location"
        case phone = "phone_number"
        case email = "school_email"
        case website = "website"
    }
}

struct SATScore: Decodable {
    var reading: String
    var writing: String
    var math: String
    
    enum CodingKeys: String, CodingKey {
        case reading = "sat_critical_reading_avg_score"
        case writing = "sat_writing_avg_score"
        case math = "sat_math_avg_score"
    }
}
