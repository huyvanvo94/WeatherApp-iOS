//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/10/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import UIKit
import GooglePlaces
import CoreLocation


class AddCityViewController: UITableViewController, GMSAutocompleteViewControllerDelegate {
    
    lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.hidesWhenStopped = true
        
        // Set Center
        var center = self.view.center
        if let navigationBarFrame = self.navigationController?.navigationBar.frame {
            center.y -= (navigationBarFrame.origin.y + navigationBarFrame.size.height)
        }
        activityIndicatorView.center = center
        
        self.view.addSubview(activityIndicatorView)
        return activityIndicatorView
    }()
    
    var placesWeather = [WeatherModel]()
    
     
    override func loadView() {
        super.loadView()
        print("loadView")
         
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        super.viewWillAppear(animated)
        
        WeatherApp.shared.requestLocation()
        WeatherApp.shared.add(delegate: self)
        
        startTimer()
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
    
    //MARK- Actions
    @IBAction func addCurrentLocation(_ sender: UIBarButtonItem) {
 
       
        self.displayAnimateSuccess()
        WeatherApp.shared.fetchCurrentLocation()
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
        
        self.goToVC(with: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! CityCell
        
        let index = indexPath.row
        
        cell.cityName.text = self.placesWeather[index].city ?? "No Name"
        if let temp = self.placesWeather[index].temp{
            if currentTempUnit == .c{
                let tempString = String(Int(Double.toCelsius(value: temp)))
                cell.currentTemp.text = String.toTemperature(value: tempString)
            }else{
                let tempString = String(Int(temp))
                cell.currentTemp.text = String.toTemperature(value: tempString)
            }
            
        }
        //cell.currentTemp.text = "\(self.placesWeather[index].temp?.rounded())"
        cell.localTime.text = self.placesWeather[index].city_local_time ?? self.placesWeather[index].local_time
        //cell.textLabel?.text = self.placesWeather[indexPath.row].city ?? "No Name"
      
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let index = indexPath.row
            WeatherApp.shared.delete(at: index)
           // placesWeather.remove(at: index)
             
        }
    }
  
    // Handle the user's selection.
    open func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
      //  self.activityIndicatorView.startAnimating()
        
        let city = place.name
        
        let place = Place(city: city, longitude: place.coordinate.longitude as Double, latitude: place.coordinate.latitude as Double)
        
        
        WeatherApp.shared.addPlace(place)
  
        
        dismiss(animated: true, completion: nil)
    }
 
 
    open func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
     
        
    
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
    

    @IBAction func goToForecastPageVC(_ sender: Any) {
        
        if WeatherApp.shared.places.isEmpty{
            return
        }
        
        self.goToVC(with: 0)
    }
    
    @objc func updateTable(){
        self.tableView.reloadData()
        
        startTimer()
    }
    
    
    func startTimer(){
        
        Timer.scheduledTimer(timeInterval: TimeInterval(Date.timer), target: self, selector: #selector( updateTable), userInfo: nil, repeats: false)
         
    }
    func goToVC(with index: Int){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForecastPageViewController") as? ForecastPageViewController{
            
            vc.index = index 
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension AddCityViewController: WeatherAppDelegate{
    
    func location(_ location: CLLocation) {
        
    }
    
    func reload(){
        self.view.reloadInputViews()
    }
    
    func load(weather: Weather){
        
    }
    
    func remove(at index: Int) {
        self.placesWeather.remove(at: index)
        self.tableView.reloadData()
        
    }
    
    func load(weatherModel: WeatherModel){
        
        print("load")
        
        if self.placesWeather.contains(where: {$0.city == weatherModel.city}){
            return
        }
        
        self.placesWeather.append(weatherModel)
        self.tableView.reloadData()
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
  
}
