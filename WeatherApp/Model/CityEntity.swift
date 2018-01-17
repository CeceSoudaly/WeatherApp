//
//  CityEntity+CoreDataClass.swift
//  
//
//  Created by Cece Soudaly on 1/16/18.
//
//

import Foundation
import CoreData


public class CityEntity: NSManagedObject {
    public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }
    
    @NSManaged public var selectCity: String?
    
    
    // Keys to convert dictionary into object
    struct Keys {
        
        static let cityText = "selectedCity"
        
    }
    
    // Init method to insert object in core data
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    
    convenience init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        
        // An EntityDescription is an object that has access to all
        // the information you provided in the Entity part of the model
        // you need it to create an instance of this class.
        if let ent = NSEntityDescription.entity(forEntityName: "CityEntity", in: context) {
            self.init(entity: ent, insertInto: context)
            
            if(dictionary[Keys.cityText]  != nil ){
                self.selectCity = dictionary[Keys.cityText] as! String
            }
            
            
        } else {
            fatalError("Unable to find Entity name!")
        }
    }


}
