//
//  TemperatureViewController.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 2/12/18.
//  Copyright © 2018 CeceMobile. All rights reserved.
//



import UIKit
import CoreData

class TemperatureViewController: UIViewController {
    @IBOutlet weak var TemperatureImage: UIImageView!
    
    @IBOutlet weak var City: UILabel!
    
    @IBOutlet weak var CurrentTemp: UILabel!
    
    @IBOutlet weak var Main: UILabel!
    
    @IBOutlet weak var Description: UILabel!
    
    @IBOutlet weak var CurrentDate: UILabel!
    
    @IBOutlet weak var tempActivity: UIActivityIndicatorView!
    
    var cellViewModels = [WeatherCellViewModel]()
    var selectedCity  = "Minneapolis"
    var selectedState = "MN"
    
    override func viewDidLoad() {
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        
        let newBackButton = UIBarButtonItem(image: UIImage(named: "back-button"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(TemperatureViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        //Activity indicator
        tempActivity.startAnimating()
        
        //make sure the city is mapped from search
        if Reachability.isConnectedToNetwork() == true {
            debugPrint("Internet connection OK")
            if(selectedCity != nil)
            {
                getCurrentTempByCity()
            }
            else{
                let alert = UIAlertView(title: "Select a City", message: "Please select a city to check the current temperature.", delegate: nil, cancelButtonTitle: "OK")
                alert.show()
            }
            
            //done with work
            tempActivity.stopAnimating()
            
        } else {
            debugPrint("Internet connection FAILED")
            var alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        
    }
    
    func getCurrentTempByCity()
    {
        TemperatureAPI.weatherBySearchCity(city: self.selectedCity) { (result) in
            guard let weatherResult = result else { return }
            
            DispatchQueue.main.async() { () in
                self.City.text = weatherResult.cityName
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy"
                
                dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy"
                let currentDateString: String = dateFormatter.string(from: date)
                print("Current date is \(currentDateString)")
                self.CurrentDate.text = currentDateString
                
                if let temperatureC = weatherResult.temperatureC {
                    //  self.CurrentTemp.text = String(temperatureC) + " °C"
                    self.CurrentTemp.text = String(self.temperatureInFahrenheit(temperature: Double(temperatureC))) + " °F"
                } else {
                    self.CurrentTemp.text = "No temperature available"
                }
                self.Main.text = weatherResult.main
                self.Description.text = weatherResult.description
            }
            
            TemperatureAPI.weatherIconForIconCode(iconCode: weatherResult.iconString, completion: { (image) -> Void in
                DispatchQueue.main.async(){ () -> Void in
                    self.TemperatureImage.image = image
                };
            })
        }
    }
    
    func temperatureInFahrenheit(temperature: Double) -> Double {
        let fahrenheit = (temperature  * 9) / 5 + 32
        return fahrenheit
    }
    
    func deleteWeather(results: [WeatherEntity]) {
        var _:NSError? = nil
        
        for objectDelete in results {
            CoreDataManager.getContext().delete(objectDelete)
            CoreDataManager.saveContext()
        }
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        // Perform your custom actions
        // ...
        // Go back to the previous ViewController
         dismiss(animated: true, completion: nil)
    }
    
}
