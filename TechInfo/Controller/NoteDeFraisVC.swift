//
//  FactureVC.swift
//  TechInfo
//
//  Created by Adel on 28/05/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import UIKit

var tap = ["cat", "dog", "rabbit"]
var tapDetail = ["cat is an animal", "dos is dog", "rabbit love to jump arround"]
var myIndex = 0

class NoteDeFraisVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tap.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FactureCell", for: indexPath)

        cell.textLabel?.text = tap[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "FactSegue", sender: self)
    }

}
