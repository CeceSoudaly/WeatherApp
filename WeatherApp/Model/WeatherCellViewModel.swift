//
//  File.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 12/9/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//

import UIKit

struct WeatherCellViewModel{
    let url: String
    let day: String
    let description: String
    
    func loadImage(completion: @escaping (UIImage?) -> Void){
        let urlString = NSURL(string: url)
        guard let imageData = try? Data(contentsOf: urlString as! URL) else
        {
            return
        }
        
        let image = UIImage(data: imageData)
        
        DispatchQueue.main.async {
            completion(image)
        }
    }
}
