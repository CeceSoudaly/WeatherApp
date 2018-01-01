//
//  SelectCityState.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 12/31/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//

import Foundation
import UIKit


class SelectCityState: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var citySelectPicker: UIPickerView!
    
    @IBOutlet weak var SelectedCity: UILabel!
    
    var CityList = [ "AL Montgomery","AK Juneau","AZ Phoenix","AR Little Rock","CA Sacramento","CA San Francisco","CA Los Angeles","CO Denver","CT Hartford", "DE Dover", "FL Tallahassee","FL Miami","FL Orlando","GA Atlanta","HI Honolulu","ID Boise","IL Springfield","IN Indianapolis","IA Des Moines","KS Topeka","KY Frankfort","LA Baton Rouge","ME Augusta","MD Annapolis","MA Boston","MI Lansing", "MN Saint Paul", "MS Jackson", "MO Jefferson City",
         "MT Helena","NE Lincoln","NV Carson City", "NH Concord", "NJ Trenton","NM Santa Fe","NY Albany",
          "NC Raleigh","ND Bismarck","OH Columbus", "OK Oklahoma City","OR Salem","PA Harrisburg",
           "RI Providence","SC Columbia","SD Pierre",
           "TN Nashville", "TX Austin", "UT Salt Lake City", "VT Montpelier", "VA Richmond", "WA Olympia",
          "WV Charleston", "WI Madison","WY Cheyenne"]
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
       
        citySelectPicker.delegate = self
        citySelectPicker.dataSource = self
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.CityList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.CityList.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        SelectedCity.text = self.CityList[row]
    }
    
   
    
    
}
