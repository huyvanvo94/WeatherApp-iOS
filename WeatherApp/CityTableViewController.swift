//
//  CityTableViewController.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/10/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import UIKit
import GooglePlaces

class CityTableViewController: UITableViewController, GMSAutocompleteViewControllerDelegate {
    
    var cities = ["Alameda", "Oakland"]
    var deleteAtIndex: IndexPath? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
   
       
    }
 
    @IBAction func searchCity(_ sender: UIBarButtonItem) {
        
        searchAndAddCity()
    }
    func searchAndAddCity() {
        let autocompleteController = GMSAutocompleteViewController()
        let filterByCity = GMSAutocompleteFilter()
        filterByCity.type = .city
        autocompleteController.autocompleteFilter = filterByCity
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
 
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
    
        cell.textLabel?.text = cities[indexPath.row]
      
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteAtIndex = indexPath
            if let index = deleteAtIndex?.row{
                confirmDelete(city: cities[index])
            }
        }
    }
    
    func confirmDelete(city: String){
        let alert = UIAlertController(title: "Delete City", message: "Are you sure you want to delete \(city)?",  preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteCity)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: handleCancelDelete)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // set variable back to nil
    func handleCancelDelete(alertAction: UIAlertAction!) -> Void{
        deleteAtIndex = nil
    }
    func handleDeleteCity(alertAction: UIAlertAction!) -> Void{
        if let indexPath = deleteAtIndex {
           // self.tableView.deleteRows(at: [indexPath], with: .fade)
            deleteAtIndex = nil
            cities.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
                       
        }
    }
    // Handle the user's selection.
    public func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
      
        cities.append(place.name)
        self.tableView.reloadData()
        
        // name of the city
        let city = place.name
        
        let latlon = LatLon(latitude: place.coordinate.latitude as Double, longitude: place.coordinate.longitude as Double)
        
        // to update the UI
        FetchWeatherEvent(city: city, latlon: latlon).asyncFetchWeather(completion: postToUI)
        FetchForecastEvent(city: city, latlon: latlon).asyncFetchForecast(completion: nil)
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func postToUI(weather: WeatherModel){
        print("postToUI \(weather.city!)")
        
        
        
    }
    
    public func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    public func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    public func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    public func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }

}
