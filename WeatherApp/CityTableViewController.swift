//
//  CityTableViewController.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/10/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import UIKit
import GooglePlaces

class CityTableViewController: UITableViewController, GMSAutocompleteViewControllerDelegate, WeatherAppDelegate {
    func load(weather: Weather){
        
    }
    func load(weather: WeatherModel) {
        print("load")
       
        if let _ = placesWeather.index(of: weather){
            return
        }
        
        self.placesWeather.append(weather)
        self.tableView.reloadData()
        
        
    }
    
    var cities = [String]()
    
    
    var placesWeather = [WeatherModel]()
    
    var deleteAtIndex: IndexPath? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)
        WeatherApp.shared.add(delegate: self)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.tableView.reloadData), userInfo: nil, repeats: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear")
        super.viewWillDisappear(animated)
        WeatherApp.shared.remove(delegate: self)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
      
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
     
        return self.placesWeather.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("row selected: \(indexPath.row)")
     
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController{
            
            let app = UIApplication.shared.delegate as! AppDelegate
            
            app.index = indexPath.row 
           // vc.index = indexPath.row
            self.present(vc, animated: true, completion: nil)
        }
         
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
    
        cell.textLabel?.text = self.placesWeather[indexPath.row].city ?? "No Name"
      
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteAtIndex = indexPath
            if let index = deleteAtIndex?.row{
                confirmDelete(cities[index])
            }
        }
    }
    
    func confirmDelete(_ city: String){
        let alert = UIAlertController(title: "Delete City", message: "Are you sure you want to delete \(city)?",  preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteCity)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: handleCancelDelete)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    // set variable back to nil
    func handleCancelDelete(_ alertAction: UIAlertAction!) -> Void{
        deleteAtIndex = nil
    }
    func handleDeleteCity(_ alertAction: UIAlertAction!) -> Void{
        if let indexPath = deleteAtIndex {
           // self.tableView.deleteRows(at: [indexPath], with: .fade)
            deleteAtIndex = nil
            cities.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
                       
        }
    }
    // Handle the user's selection.
    open func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        if let activityIndicator = view.viewWithTag(123) as? UIActivityIndicatorView{
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
        }
        
        let city = place.name
        
        let place = Place(city: city, longitude: place.coordinate.longitude as Double, latitude: place.coordinate.latitude as Double)
        
        
        WeatherApp.shared.addPlace(place)
  
        
        dismiss(animated: true, completion: nil)
    }
 
 
 
    open func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
     
        showToast(message: "cannot fetch weather")
    }
    
    // User canceled the operation.
    open func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    open func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    open func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func loadTodayWeather(weatherModels: [WeatherModel]){
        
    }
    
    func loadWeather(weather: WeatherModel){
        
    }
    
 

}

extension UIViewController {
    // return to previous view
    func performSegueToReturnBack()  {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    

}
