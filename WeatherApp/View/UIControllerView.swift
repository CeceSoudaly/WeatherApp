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


class  UIControllerView:  UIViewController,UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate, LocateOnTheMap,GMSAutocompleteFetcherDelegate
{
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var resultsCityArray = [CityEntity]()
    var selectedCity  = "Minneapolis"
    var selectedState = "MN"
    //var selectedIndexPaths = [NSIndexPath]()
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print("viewDidLoad")
        tableView.dataSource = self
        tableView.delegate = self
      
        
        //load core data
        resultsCityArray = self.fetchAllCity();
        
        
        print("You have fetch coredata ",resultsCityArray.count)
        
        if(resultsCityArray.count > 5)
        {
            self.deleteFromCoreData(selectedCities: resultsCityArray)
            resultsCityArray.removeAll()
            
        }
        
         DispatchQueue.main.async()  {
             self.tableView.reloadData()
        }

    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //currently only a testing number
        return resultsCityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
      
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "temperatureCell")
        let city = resultsCityArray[indexPath.row]
        //let cellVievData = city.selectCity
        cell.textLabel?.text = city.selectCity
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)")
        NSLog("what did you select : \(resultsCityArray[indexPath.row])")
      
 
        let city = resultsCityArray[indexPath.row]
        var fullName: String = city.selectCity!
        let fullNameArr = fullName.components(separatedBy: ", ")
        print(fullNameArr.count)
        self.selectedState  = fullNameArr[1]
        
         print("You selected State: \( self.selectedState )")
        self.selectedCity = fullNameArr[0]
        print("You selected city: \( self.selectedCity )")
        
        //Get the temperature for the selected city and state.
        self.performSegue(withIdentifier: "TempDetail", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TempDetail"{
        
            if let controller = segue.destination.childViewControllers[0] as? WeatherTableViewController {
                    controller.selectedCity = self.selectedCity
                    print(controller.selectedCity)
        
                    controller.selectedState = self.selectedState
                    print(controller.selectedState)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete{
            
            if resultsCityArray.count > 0 {
                for cityDelete in resultsCityArray {
                    //loop through to get the selected city and remove it.
                    if( cityDelete == resultsCityArray[indexPath.row])
                    {
                        let index: Int = (self.resultsCityArray as NSArray).index(of: cityDelete)
                        self.resultsCityArray.remove(at: index)
                        CoreDataManager.getContext().delete(cityDelete)
                        break
                    }
                    
                }
                CoreDataManager.saveContext()
            }
        }
        
        self.tableView.reloadData()
    }
    
    
    @IBAction func selectLocation(_ sender: Any) {
        
        print("Seach City")
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        let searchControllerDef = UISearchController(searchResultsController: resultsViewController)
        searchControllerDef.searchResultsUpdater = resultsViewController
        
        searchControllerDef.searchBar.delegate = self
        
        self.present(searchControllerDef, animated:true, completion: nil)
    }
    
    func saveToCoreData(selectedCity: String, cityEntity: CityEntity)
    {
        //note: only create 1 instance of enity per record
        do {
            try  CoreDataManager.saveContext()

        } catch {
            print("Error while trying to save the Selected City: \(error)")
        }
    }
    
    func  deleteFromCoreData(selectedCities: [CityEntity])
    {
        
        do {
            var _:NSError? = nil
            
            var results:[CityEntity]!
            results = self.fetchAllCity();
            
            for objectDelete in results {
                    CoreDataManager.getContext().delete(objectDelete)
                    CoreDataManager.saveContext()
                //    break
            }
            
        } catch {
            print("Error while trying to delete the Selected City: \(error)")
        }
    }

    func fetchAllCity() -> [CityEntity] {
        var error:NSError? = nil
        var results:[CityEntity]!
        do{
            //Create the fetch request
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CityEntity")
            results = try CoreDataManager.getContext().fetch(fetchRequest) as! [CityEntity]
            
            print("how many were stored in cordata? ",results.count)
        }
        catch{
            print("Error in fetchAllCity")
        }
        return results
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
extension  UIControllerView: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        print("Place name: \(place.name)")
        print("Place address: \(place.formattedAddress)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
     
        //creating  a new instance of CityEntity
        let newCityEntity = CityEntity(context: CoreDataManager.getContext())
        
        //Save select city to core data, convert selected city string to entity and append to the array
        saveToCoreData(selectedCity: place.formattedAddress!, cityEntity: newCityEntity)
        
        newCityEntity.selectCity = place.formattedAddress!
        resultsCityArray.append(newCityEntity)
        self.tableView.beginUpdates()

        tableView.insertRows(at: [IndexPath(row: resultsCityArray.count - 1 , section: 0)], with: .automatic)
        self.tableView.endUpdates()
  
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

