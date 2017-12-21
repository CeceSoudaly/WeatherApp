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
    
    // Init method to insert object in core data
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    
    convenience init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        
        // An EntityDescription is an object that has access to all
        // the information you provided in the Entity part of the model
        // you need it to create an instance of this class.
        if let ent = NSEntityDescription.entity(forEntityName: "Weather", in: context) {
            self.init(entity: ent, insertInto: context)
            
            if(dictionary[Keys.forecastText] != nil ){
                self.forecastText = dictionary[Keys.forecastText] as! String
            }
            
            if(dictionary[Keys.date]  != nil ){
                self.date = dictionary[Keys.date] as! String
            }
            
            if(dictionary[Keys.forecastDays]  != nil ){
                self.forecastDays = dictionary[Keys.forecastDays] as! String
            }
            
            if(dictionary[Keys.iconUrl]  != nil ){
                self.iconUrl = dictionary[Keys.iconUrl] as! String
            }
            
            if(dictionary[Keys.day]  != nil ){
                self.day = dictionary[Keys.day] as! String
            }
            
            if(dictionary[Keys.tempdescription]  != nil ){
                self.tempDescription = dictionary[Keys.tempdescription] as! String
            }
            
        } else {
            fatalError("Unable to find Entity name!")
        }
    }


}
