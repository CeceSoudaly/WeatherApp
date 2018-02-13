//
//  EndPoint.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 11/27/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//

import Foundation

protocol Endpoint {
    
   
    var baseURL:String { get }
    var path:String { get }
    var queryItems:[URLQueryItem] { get }
}

extension Endpoint{
    var urlComponent: URLComponents{
        var component = URLComponents(string: baseURL)
        component?.path = path
        component?.queryItems = queryItems
        
        return component!
    }
    
    var request: URLRequest{
       print("url....",urlComponent.url)
       return URLRequest(url: urlComponent.url!)
        
    }
}

enum WeatherEndpoint: Endpoint{
    
    case tenDayForecast(city: String, state: String)
    
    var  baseURL:String{
      return "https://api.wunderground.com"
    }
    
    var path: String{
        switch self{
        case .tenDayForecast(let city, let state):
           return "/api/395bc939b683474d/forecast10day/q/\(state)/\(city).json"
        }
    }
    
    var queryItems: [URLQueryItem]{
        return[]
    }
    
    
}



