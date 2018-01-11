//
//  WeatherEntity+CoreDataClass.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 12/30/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//
//

import Foundation
import CoreData


public class WeatherEntity: NSManagedObject {
    
    public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity")
    }
    
    @NSManaged public var day: String?
    @NSManaged public var iconURL: String?
    @NSManaged public var period: NSNumber?
    @NSManaged public var tempDescription: String?
    @NSManaged public var forcastDays: [Double]?
    @NSManaged public var forecastText: [Double]?
    
    // Keys to convert dictionary into object
    struct Keys {
        
        static let forecastText = "txt_forecast"
        static let date = "date"
        static let forecastDays = "forecastday"
        static let period = "period"
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
        if let ent = NSEntityDescription.entity(forEntityName: "WeatherEntity", in: context) {
            self.init(entity: ent, insertInto: context)
            
            if(dictionary[Keys.period]  != nil ){
                self.period = dictionary[Keys.period] as! NSNumber
            }

            if(dictionary[Keys.iconUrl]  != nil ){
                self.iconURL = dictionary[Keys.iconUrl] as! String
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
