//
//  Temperature.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 2/11/18.
//  Copyright © 2018 CeceMobile. All rights reserved.
//

import Foundation
import UIKit

class Temperature {
    
    static let kWeatherKey = "weather"
    static let kMainKey = "main"
    static let kDescriptionKey = "description"
    static let kIconKey = "icon"
    static let kTemperatureKey = "temp"
    static let kNameKey = "name"
    
    var main = ""
    var description = ""
    var iconString = ""
    var iconImage: UIImage?
    var temperatureK: Float?
    var cityName = ""
    var temperatureC: Float? {
        get {
            if let temperatureK = temperatureK {
                return temperatureK - 273.15
            } else {
                return nil
            }
        }
    }
    
    
    init(jsonDictionary: [String : AnyObject]) {
        
        if let arrayUsingWeatherKey = jsonDictionary[Temperature.kWeatherKey] as? [[String : AnyObject]] {
            if let main = arrayUsingWeatherKey[0][Temperature.kMainKey] as? String {
                self.main = main
            }
            if let description = arrayUsingWeatherKey[0][Temperature.kDescriptionKey] as? String {
                self.description = description
            }
            if let iconString = arrayUsingWeatherKey[0][Temperature.kIconKey] as? String {
                self.iconString = iconString
            }
        }
        
        if let main = jsonDictionary[Temperature.kMainKey] as? [String : AnyObject] {
            if let temperature = main[Temperature.kTemperatureKey] as? NSNumber {
                self.temperatureK = Float(temperature)
            }
        }
        
        if let cityName = jsonDictionary[Temperature.kNameKey] as? String {
            self.cityName = cityName
        }
    }
}
