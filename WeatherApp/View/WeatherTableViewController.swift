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
        
        var cellViewModels = [WeatherCellViewModel]()
        
        
        super.viewDidLoad()
        let weatherApi = WeatherAPIClient()
        let weatherEndpoint = WeatherEndpoint.tenDayForecast(city: "Boston", state: "MA")
        
        weatherApi.weather(with: weatherEndpoint){ (either) in
            switch either{
            case .value(let forecastText):
                cellViewModels = forecastText.forecastDays.map {
                    WeatherCellViewModel(url: $0.iconUrl , day: $0.day, description: $0.description)
                }
                
            case .error(let error):
                print(error)
            }
            
        }
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
