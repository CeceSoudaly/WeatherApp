//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 11/23/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WheatherCell", for: indexPath)

        // Configure the cell...
    

        return cell
    }
   

}
