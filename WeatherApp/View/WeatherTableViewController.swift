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
    var selectedCity  = "Minneapolis"
    var selectedState = "MN"
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        let weatherApi = WeatherAPIClient()
        
        let weatherEndpoint = WeatherEndpoint.tenDayForecast(city: selectedCity, state: selectedState)
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        print("Current date", date)
        
        //Check to see if we have it stored on CoreData
        //If no data we go back to get a new set of
        
        var resultsWeatherEntity = self.fetchAllTempetures()
        print("how many record saved in core data>>>> ",resultsWeatherEntity.count)
        
        if(resultsWeatherEntity.count > 0)
        {
            var WeatherList:[ForecastDay] = []
           
            for saveWeather in resultsWeatherEntity {
                
                let foreCast = ForecastDay.init(period: saveWeather.period as! Double, iconUrl: saveWeather.iconURL!, day: saveWeather.day!, description: saveWeather.tempDescription!)
                 WeatherList.append(foreCast)
           }
          
            self.cellViewModels = WeatherList.map {
                //display
                WeatherCellViewModel(url: $0.iconUrl, day: $0.day, description: $0.description)
            }
           
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            self.deleteWeather(results: resultsWeatherEntity)
        }
        else{
            weatherApi.weather(with: weatherEndpoint){ (either) in
                switch either{
                case .value(let forecastText):
                    //save to core data
                    self.saveToCoreData(ForecastList: forecastText)
                    self.cellViewModels = forecastText.forecastDays.map {
                        //display
                        WeatherCellViewModel(url: $0.iconUrl, day: $0.day, description: $0.description)
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
    
    func saveToCoreData(ForecastList: ForecastText)
    {
       
      ForecastList.forecastDays.map {

       let weatherDictionary: [String : AnyObject] = [
               WeatherEntity.Keys.period : $0.period   as AnyObject,
               WeatherEntity.Keys.iconUrl :  $0.iconUrl   as AnyObject,
               WeatherEntity.Keys.day : $0.day as String as AnyObject,
               WeatherEntity.Keys.tempdescription : $0.description as String as AnyObject

        ]
            WeatherEntity(dictionary: weatherDictionary, context: CoreDataManager.getContext())
        }
       
        do {
             try  CoreDataManager.saveContext()
            
        } catch {
            print("Error while trying to save : \(error)")
        }
    }
    
    
    func fetchAllTempetures() -> [WeatherEntity] {
        var _:NSError? = nil
        var results:[WeatherEntity]!
        do{
            //Create the fetch request and sort the order of the days
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "WeatherEntity")
            fetchRequest.sortDescriptors = [ NSSortDescriptor( key: #keyPath(WeatherEntity.period), ascending: true) ]
            results = try CoreDataManager.getContext().fetch(fetchRequest) as! [WeatherEntity]
            print("results >>>",results.count);
        }
        catch{
            print("Error in fetchAllLocations")
        }
        return results
    }
    
    func deleteWeather(results: [WeatherEntity]) {
        var _:NSError? = nil
        
        for objectDelete in results {
                CoreDataManager.getContext().delete(objectDelete)
                CoreDataManager.saveContext()
        }
        
         print("after DELETE results >>>",self.fetchAllTempetures().count);
     }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cellViewModels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TempCel", for: indexPath)

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
