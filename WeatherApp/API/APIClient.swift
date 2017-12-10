//
//  APIClient.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 11/24/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//

import Foundation

enum Either<V, E: Error>{
    case value(V)
    case error(E)
}

enum APIError: Error {
    case apiError
    case badResponse
    case jsonDecoder
    case unknow(String)
}

protocol APIClient {
    var session: URLSession { get }
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping (Either <V, APIError>) -> Void)
}

extension APIClient{
    func fetch<V: Codable>(with request: URLRequest, completion: @escaping (Either <V, APIError>) -> Void){
        
        let task = session.dataTask(with: request){(data, respond, error) in
            
            guard error == nil else{
                completion(.error(.apiError))
                return
            }
          
//            print("respond.statusCode >>>> ",respond)
            
            guard let respond = respond as? HTTPURLResponse, 200 ..< 300 ~= respond.statusCode else{
                completion(.error(.badResponse))
                return
            }
            print(data)

            
            do {
                // Decode data to object
                guard let value = try? JSONDecoder().decode(V.self, from: data!) else{
                    completion(.error(.jsonDecoder))
                    return
                }
    
               completion(.value(value))
            
                
            }
            catch {
                
                print("error while decoding weather data. ",error)
            }
            
        }
        
        task.resume()
    }
    
    /* Helper: Given raw JSON, return a usable Foundation object */
 func parseJSONWithCompletionHandler(data: NSData, completionHandler: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: AnyObject!
        do {
            
            let json = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? [String : Any]
            
            parsedResult = json as AnyObject
            
            let posts = parsedResult["posts"] as? [[String: Any]] ?? []
            
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandler(nil, NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandler(parsedResult, nil)
    }
}
