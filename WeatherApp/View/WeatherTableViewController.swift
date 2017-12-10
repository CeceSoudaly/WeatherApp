//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 11/23/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//

import UIKit

class WeatherTableViewController: UITableViewController {
    var cellViewModels = [WeatherCellViewModel]()
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        let weatherApi = WeatherAPIClient()
        let weatherEndpoint = WeatherEndpoint.tenDayForecast(city: "Boston", state: "MA")
        
        weatherApi.weather(with: weatherEndpoint){ (either) in
            switch either{
            case .value(let forecastText):
                
                self.cellViewModels = forecastText.forecastDays.map {
                    WeatherCellViewModel(url: $0.iconUrl , day: $0.day, description: $0.description)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .error(let error):
                print(error)
            }
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cellViewModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WheatherCell", for: indexPath)

        // Configure the cell...
        let cellViewModel = cellViewModels[indexPath.row]
        cell.textLabel?.text = cellViewModel.day
        cell.detailTextLabel?.text = cellViewModel.description
        cellViewModel.loadImage{ (image)in
             cell.imageView?.image = image
        }
        return cell
    }
   

}
