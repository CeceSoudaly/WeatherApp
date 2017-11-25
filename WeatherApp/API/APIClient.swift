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
                completion(.error(.apierror))
                return
            }
            
            guard let respond = respond as? HTTPURLResponse, 200..<300 -= respond.statusCode else{
                completion(.error(.badResponse))
                return
            }
            
            
        }
    }
}
