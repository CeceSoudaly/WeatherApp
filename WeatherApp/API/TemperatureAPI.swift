//
//  TemperatorAPI.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 2/12/18.
//  Copyright © 2018 CeceMobile. All rights reserved.
//

import Foundation
import UIKit

class TemperatureAPI {
    
    static func weatherBySearchCity(city: String, completion:@escaping (_ result: Temperature?) -> Void) {
        
        let url = EndPointNetWork.searchURLByCity(city: city)
        
        EndPointNetWork.dataAtURL(url: url) { (resultData) -> Void in
            
            guard let resultData = resultData
                else {
                    debugPrint("NO DATA RETURNED")
                    completion(nil)
                    return
            }
            
            do {
                let weatherAnyObject = try JSONSerialization.jsonObject(with: resultData as Data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                
                var tempModelObject: Temperature?
                
                if let temperatureDictionary = weatherAnyObject as? [String : AnyObject] {
                    tempModelObject = Temperature(jsonDictionary: temperatureDictionary)
                }

                
                completion(tempModelObject)
                
            } catch {
                completion(nil)
            }
            
        }
    }
    
    static func weatherIconForIconCode(iconCode: String, completion:@escaping (_ image: UIImage?) -> Void) {
        let url = EndPointNetWork.urlForIcon(iconString: iconCode)
        
        EndPointNetWork.dataAtURL(url: url) { (resultData) -> Void in
            guard let resultData = resultData
                else {
                    debugPrint("NO DATA RETURNED")
                    completion(nil)
                    return
            }
            completion(UIImage(data: resultData as Data))
        }
    }
}
