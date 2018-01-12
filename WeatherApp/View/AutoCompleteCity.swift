//
//  AutoCompleteCity.swift
//  WeatherApp
//
//  Created by Cece Soudaly on 1/9/18.
//  Copyright © 2018 CeceMobile. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class  AutoCompleteCity:  UIViewController , UISearchBarDelegate , LocateOnTheMap,GMSAutocompleteFetcherDelegate  {
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
       // <#code#>
    }
    
    func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        //<#code#>
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
       
        print(resultsArray)
    }
    
    func didFailAutocompleteWithError(_ error: Error) {
        //<#code#>
    }
    
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
//    var resultView: UITextView?
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
//    var gmsFetcher: GMSAutocompleteFetcher!
 
    @IBAction func searchCity(_ sender: Any) {
        
        print("Blah Blah Seach City")
//        resultsViewController = GMSAutocompleteResultsViewController()
//        resultsViewController?.delegate = self
//        let searchController = UISearchController(searchResultsController: resultsViewController)
//
//        searchController.searchBar.delegate = self
//
//        self.present(searchController, animated:true, completion: nil)
//
        let searchController = UISearchController(searchResultsController: searchResultController)

        searchController.searchBar.delegate = self



        self.present(searchController, animated:true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self

        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController

        let subView = UIView(frame: CGRect(x: 0, y: 65.0, width: 350.0, height: 45.0))

        subView.addSubview((searchController?.searchBar)!)
        view.addSubview(subView)
        searchController?.searchBar.sizeToFit()
        searchController?.hidesNavigationBarDuringPresentation = false

        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
    }
}


// Handle the user's selection.
extension  AutoCompleteCity: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
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
