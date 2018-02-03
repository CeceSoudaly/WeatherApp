//
//  SelectCityState.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 12/31/17.
//  Copyright © 2017 CeceMobile. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps



class SelectCityState: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var citySelectPicker: UIPickerView!
    
    @IBOutlet weak var SelectedCity: UILabel!
    
    var googleMapView: GMSMapView!
    
    var CityList = [ "AL Montgomery","AK Juneau","AZ Phoenix","AR Little Rock","CA Sacramento","CA San Francisco","CA Los Angeles","CO Denver","CT Hartford", "DE Dover", "FL Tallahassee","FL Miami","FL Orlando","GA Atlanta","HI Honolulu","ID Boise","IL Springfield","IN Indianapolis","IA Des Moines","KS Topeka","KY Frankfort",
        "LA Baton Rouge","ME Augusta","MD Annapolis","MA Boston","MI Lansing", "MN Saint Paul", "MS Jackson",
        "MO Jefferson City","MT Helena","NE Lincoln","NV Carson City", "NH Concord", "NJ Trenton","NM Santa Fe","NY Albany",
        "NC Raleigh","ND Bismarck","OH Columbus", "OK Oklahoma City","OR Salem","PA Harrisburg", "RI Providence",
        "SC Columbia","SD Pierre","TN Nashville", "TX Austin", "UT Salt Lake City", "VT Montpelier", "VA Richmond",
        "WA Olympia", "WV Charleston", "WI Madison","WY Cheyenne"]
    
    var selectedCity  = "Minneapolis"
    
    var selectedState = "MN"
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
       
        citySelectPicker.delegate = self
        citySelectPicker.dataSource = self
        
        //AIzaSyCi9T8T4PbvlfIPZVQK3StCBXOneDBK4OY
        // var urlString = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(searchString)&sensor=true&key=\(Google_Browser_Key)"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
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
        var fullName: String = self.CityList[row]
        let fullNameArr = fullName.components(separatedBy: " ")
        print(fullNameArr.count)
        self.selectedState  = fullNameArr[0]
        
        if(fullNameArr.count > 2)
        {
             self.selectedCity = fullNameArr[1] + " " + fullNameArr[2]
 
        }else{
            self.selectedCity = fullNameArr[1]
     
        }
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Weather"{
                 let controller = segue.destination as! WeatherTableViewController
                controller.selectedCity = self.selectedCity
                print(controller.selectedCity)
            
                controller.selectedState = self.selectedState
                print(controller.selectedState)
         }
    }
    
    @IBAction func Temperature(_ sender: Any) {
        
        performSegue(withIdentifier: "Weather", sender: view)
    }
    
}
