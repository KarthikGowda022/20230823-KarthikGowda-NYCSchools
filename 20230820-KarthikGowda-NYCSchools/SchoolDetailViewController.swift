//
//  SchoolDetailViewController.swift
//  20230820-KarthikGowda-NYCSchools
//
//  Created by K Madeve Gowda on 21/08/23.
//

import UIKit

class SchoolDetailViewController: UIViewController {
    var school: School!
    
    
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    
    @IBOutlet weak var readingScore: UILabel!
    
    @IBOutlet weak var wrintingScore: UILabel!
    
    @IBOutlet weak var mathScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schoolName.text = school.name
        phoneNumber.text = school.phone
        address.text = school.location
        
        readingScore.text = school.satScore?.reading ?? "Unavailable"
        wrintingScore.text = school.satScore?.writing ?? "Unavailable"
        mathScore.text = school.satScore?.math ?? "Unavailable"
    }
}
