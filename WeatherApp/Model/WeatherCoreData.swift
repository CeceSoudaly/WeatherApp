//
//  Weather+CoreDataClass.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 12/19/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//
//

import Foundation
import CoreData

public class WeatherCoreData: NSManagedObject {
    
    @NSManaged public var forecastText: String?
    @NSManaged public var date: String?
    @NSManaged public var forecastDays: String?
    @NSManaged public var iconUrl: String?
    @NSManaged public var day: String?
    @NSManaged public var tempDescription: String?
    
    
    // Keys to convert dictionary into object
    struct Keys {
        
        static let forecastText = "txt_forecast"
        static let date = "date"
        static let forecastDays = "forecastday"
        static let iconUrl = "icon_url"
        static let day = "title"
        static let tempdescription = "fcttext"
    }

}
