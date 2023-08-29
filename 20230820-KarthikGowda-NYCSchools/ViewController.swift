//
//  ViewController.swift
//  20230820-KarthikGowda-NYCSchools
//
//  Created by K Madeve Gowda on 20/08/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var viewModel: SchoolViewModel = SchoolViewModel()
    
    // cell reuse id (cells that scroll out of view can be reused)
       let cellReuseIdentifier = "cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Register the table view cell class and its reuse id
        //self.tableView.register(SchoolTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        // (optional) include this line if you want to remove the extra empty cell divider lines
        // self.tableView.tableFooterView = UIView()
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "NYC High Scools"
        
        viewModel.fetchHighSchools {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.highSchools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        guard let cell  = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? SchoolTableViewCell else {
            return UITableViewCell()
        }
        
        cell.accessoryType = .disclosureIndicator
        // set the text from the data model
        let school = self.viewModel.highSchools[indexPath.row]
        if let name = school.name {
            cell.schoolName.text = name
        } else {
            cell.schoolName?.text = school.dbn
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var school = self.viewModel.highSchools[indexPath.row]
        
        viewModel.fetchSATScore(schoolId: school.dbn, completion: { scores in
            DispatchQueue.main.async {
            let detailedVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailView") as! SchoolDetailViewController
            school.satScore = scores
            detailedVC.school = school
                self.navigationController?.pushViewController(detailedVC, animated: true)
            }
        })
    }
}

class SchoolTableViewCell: UITableViewCell {
    @IBOutlet var schoolName: UILabel!
}

