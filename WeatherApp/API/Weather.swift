//
//  Weather.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 11/24/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//

import Foundation

class Weather:Codable{
    let forecast: Forecast
}

struct Forecast: Codable{
    
    let forecastText: ForecastText
    
    private enum CodingKeys: String, CodingKey{
        case forecastText = "txt_forecast"
    }
}

struct ForecastText: Codable{
    let date: String
    let forecastDays: [ForecastDay]
    
    private enum CodingKeys: String, CodingKey{
        case date
        case forecastDays = "forecastday"
    }
}

struct ForecastDay: Codable {
    let iconUrl: URL
    let day:String
    let description:String
    
    private enum CodingKeys: String, CodingKey{
        case iconUrl = "icon_url"
        case day = "title"
        case description = "fcttext"
    }
}
