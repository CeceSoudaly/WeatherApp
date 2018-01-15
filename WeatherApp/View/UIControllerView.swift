//
//  UIControllerView.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 1/14/18.
//  Copyright © 2018 CeceMobile. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreData


class  ControllerView:  UIViewController,UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate, LocateOnTheMap,GMSAutocompleteFetcherDelegate
{
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var listOfCities = ["BMW","Audi", "Volkswagen"]


    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("viewDidLoad")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()


    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
             print("listOfCities.count",listOfCities.count)
        //currently only a testing number
        return listOfCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        print("cellForRowAt",listOfCities.count)
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "temperatureCell")
        let cellVievData = listOfCities[indexPath.row]
        cell.textLabel?.text = cellVievData.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        NSLog("what did you select : \(listOfCities[indexPath.row])!")
       // self.performSegueWithIdentifier("yourIdentifier", sender: self)
    }
    
    @IBAction func selectLocation(_ sender: Any) {
        
        print("Blah Blah Seach City")
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        let searchControllerDef = UISearchController(searchResultsController: resultsViewController)
        searchControllerDef.searchResultsUpdater = resultsViewController
        
        searchControllerDef.searchBar.delegate = self
        
        self.present(searchControllerDef, animated:true, completion: nil)
    }
    
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        //  <#code#>
    }
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        //  <#code#>
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
        
        print(resultsArray)
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        // <#code#>
    }
 
}

// Handle the user's selection.
extension  ControllerView: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
         dismiss(animated: true, completion: nil)
        
        listOfCities.append(place.formattedAddress!)
        
        tableView.reloadData()
        
     
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
    
    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
}

