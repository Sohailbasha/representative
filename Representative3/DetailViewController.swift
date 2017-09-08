//
//  DetailViewController.swift
//  Representative3
//
//  Created by Ilias Basha on 9/8/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let state = state {
            RepController.getDataFor(state: state, completion: { (representatives) in
                self.representatives = representatives
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            })
        }
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    var state: String?
    var representatives: [Representative] = []


  
    @IBOutlet var tableView: UITableView!
    
    
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return representatives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "repCell", for: indexPath)
        let representative = representatives[indexPath.row]
        cell.textLabel?.text = representative.name
        return cell
    }
    
    
}
