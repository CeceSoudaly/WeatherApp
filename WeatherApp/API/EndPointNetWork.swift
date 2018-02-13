//
//  EndPointNetWork.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 2/12/18.
//  Copyright © 2018 CeceMobile. All rights reserved.
//

import Foundation

class EndPointNetWork {
    
    private static let API_KEY = "0b34ac375df98df4893123f08ae26187"
    static let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    
    static func searchURLByCity(city: String) -> NSURL {
        let escapedCityString = city
        
        return NSURL(string: baseURL + "?q=\(escapedCityString)" + "&appid=\(API_KEY)")!
    }
    
    static func urlForIcon(iconString: String) -> NSURL {
        return NSURL(string: "http://openweathermap.org/img/w/\(iconString).png")!
    }
    
    static func dataAtURL(url: NSURL, completion:@escaping (_ resultData: NSData?) -> Void) {
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url as URL) { (data, _, error) -> Void in
            
            guard let data = data  else {
                print(error?.localizedDescription)
                completion(nil)
                return
            }
            
            completion(data as NSData)
        }
        
        dataTask.resume()
    }
}
