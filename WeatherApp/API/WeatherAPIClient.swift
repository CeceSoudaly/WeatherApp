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
    
    func weather(with endpoint: WeatherEndpoint, completion: @escaping(Either<ForecastText, APIError>)->Void){
        let request = endpoint.request
        self.fetch(with: request){ (either: Either<Weather, APIError>)in
            switch either{
            case .value(let weather):
               let textForecast = weather.forecast.forecastText
               completion(.value(textForecast))
                
            case .error(let error):
                 completion(.error(error))
            }
            
        }
        
    }
}
