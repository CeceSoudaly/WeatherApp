//
//  WeatherTableViewController.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 11/23/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//

import UIKit
import CoreData

class WeatherTableViewController: UITableViewController {
    var cellViewModels = [WeatherCellViewModel]()
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        let weatherApi = WeatherAPIClient()
        let weatherEndpoint = WeatherEndpoint.tenDayForecast(city: "Minneapolis", state: "MN")
        
        //Check to see if we have it stored on CoreData
        //If no data we go back to get a new set of weather
        print(">>>> ",self.fetchAllTempetures())
        
        if(self.fetchAllTempetures().count > 0)
        {
            self.deleteWeather(results: self.fetchAllTempetures())
        }
        else{
            weatherApi.weather(with: weatherEndpoint){ (either) in
                switch either{
                case .value(let forecastText):
                    
                    //print(forecastText)
                    
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
       
    }
    
    
    func fetchAllTempetures() -> [WeatherEntity] {
        var error:NSError? = nil
        var results:[WeatherEntity]!
        do{
                //Create the fetch request
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherEntity")
                results = try CoreDataManager.getContext().fetch(fetchRequest) as! [WeatherEntity]
                print("results >>>",results.count);
                
                if(results.count > 0)
                {
                    self.deleteWeather(results: results)
                }
        }
        catch{
            print("Error in fetchAllLocations")
        }
        return results
    }
    
    func deleteWeather(results: [WeatherEntity]) {
        var _:NSError? = nil
        
      //  var results:[WeatherEntity]!
        //results = self.fetchAllTempetures();
        
        for objectDelete in results {
//            if(objectDelete.longitude == locationToDelete.longitude)
//            {
                CoreDataManager.getContext().delete(objectDelete)
                CoreDataManager.saveContext()
//                break
//            }
        }
        
         print("after results >>>",results.count);
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
