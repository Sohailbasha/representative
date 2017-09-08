//
//  StatesViewController.swift
//  Representative3
//
//  Created by Ilias Basha on 9/8/17.
//  Copyright © 2017 Sohail. All rights reserved.
//

import UIKit

class StatesViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let destinationVC = segue.destination as? DetailViewController {
                    let state = StateController.states[indexPath.row]
                    destinationVC.state = state
                }
            }
        }
    }
 

}

extension StatesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StateController.states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        cell.textLabel?.text = StateController.states[indexPath.row]
        return cell
    }
}
