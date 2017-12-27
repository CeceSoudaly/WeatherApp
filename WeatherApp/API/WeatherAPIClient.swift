//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 11/30/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//

import Foundation

class WeatherAPIClient: APIClient {
    var session: URLSession
    
    init(session: URLSession = URLSession.shared){
        self.session = session
        
    }
    
    //Making a request call to weather api 
    func weather(with endpoint: WeatherEndpoint, completion: @escaping(Either<ForecastText, APIError>)->Void){
        let request = endpoint.request
        
        //load data from API calls
        self.fetch(with: request){ (either: Either<Weather, APIError>)in
            switch either{
        
            case .value(let weather):
                let textForecast = weather.forecast.forecastText
               
                let weatherDictionary: [String : AnyObject] = [
                    WeatherEntity.Keys.forecastText :  textForecast   as AnyObject,
                    WeatherEntity.Keys.date : textForecast.date as AnyObject,
                    WeatherEntity.Keys.forecastDays : textForecast.forecastDays as AnyObject,
                    WeatherEntity.Keys.tempdescription : textForecast.forecastDays.description as AnyObject
                ]

                let weatherToBeAdded = WeatherEntity(dictionary: weatherDictionary, context: CoreDataManager.getContext())
              do {
                    try CoreDataManager.saveContext()
                 
                } catch {
                    print("Error while trying to save : \(error)")
                }
          
                completion(.value(textForecast))
                
            case .error(let error):
                 completion(.error(error))
            }
            
        }
        
    }
}
