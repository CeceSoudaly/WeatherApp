//
//  EndPointNetWork.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 2/12/18.
//  Copyright © 2018 CeceMobile. All rights reserved.
//

import Foundation

class EndPointNetWork {
   
    static func searchURLByCity(city: String) -> NSURL {
       let escapedCityString =  city.replacingOccurrences(of: " ",with:  "%20")
       
        return NSURL(string: Constant.baseURL + "?q=\(escapedCityString)" + "&appid=\(Constant.API_KEY)")!
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
