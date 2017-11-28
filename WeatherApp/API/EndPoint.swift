//
//  EndPoint.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 11/27/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get}
    var path:String { get }
}
