//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/10/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var weather: Weather?
    var threeHoursWeather = [WeatherModel]()
    var fiveDayForecast = [WeatherModel]()
    @IBOutlet weak var cityLabel: CustomSubLabel!
    @IBOutlet weak var currentTempLabel: TempLabel!
    @IBOutlet weak var localTimeLabel: CustomSubLabel!
    @IBOutlet weak var minMaxTempLabel: CustomSubLabel!
    @IBOutlet weak var conditionLabel: CustomSubLabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CityForecastPageController viewDidLoad")
    
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if WeatherApp.shared.location == nil{
            WeatherApp.shared.fetchCurrentLocation()
        }else{
            self.determineLocation(with: WeatherApp.shared.location!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadToView()
    }
 

    func loadToView(){
        
        if let weather = self.weather{
            
            if let timeZone = self.weather?.todayWeather.time_zone_id{
                
                self.load(today: weather.todayWeather)
                self.load(forecast: weather.forecastWeather, timeZone: timeZone)
                self.load(threeHours: weather.threeHoursWeather, timeZone: timeZone)
            }
             
        }
        
    }
    private func load(today: WeatherModel){
        if let city = today.city{
            cityLabel.sizeToFit()
            cityLabel.text = city
            cityLabel.adjustsFontSizeToFitWidth = true
            cityLabel.textAlignment = .left
        }
       localTimeLabel.text = today.local_date
       localTimeLabel.textAlignment = .right
        
        
        if let currentTemp = today.temp{
            if currentTempUnit == .c{
                let tempString = String(Int(Double.toCelsius(value: currentTemp)))
                currentTempLabel.text = String.toTemperature(value: tempString)
                minMaxTempLabel.text = "Min: \(String.toTemperature(value: String(Int(Double.toCelsius(value: today.temp_min!))))) Max: \(String.toTemperature(value: String(Int(Double.toCelsius(value: today.temp_max!)))))"
            }else{
                let tempString = String(Int(currentTemp))
                currentTempLabel.text = String.toTemperature(value: tempString)
                minMaxTempLabel.text = "Min: \(String.toTemperature(value: String(Int(today.temp_min!)))) Max: \(String.toTemperature(value: String(Int(today.temp_max!))))"
            }
            
        }
        
      
        
        if let condition = today.main{
            conditionLabel.text = condition
        }
 
    }
    
    
    private func load(threeHours: [WeatherModel], timeZone: String){
      
        for model in threeHours{
            model.time_zone_id = timeZone
            self.threeHoursWeather.append(model)
        }
        
        self.tableView.reloadData()
        
        
    }
    
    private func load(forecast: [WeatherModel], timeZone: String){
        for model in forecast{
            model.time_zone_id = timeZone
            self.fiveDayForecast.append(model)
        }
        
        self.collectionView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func determineLocation(with location: CLLocation){
        let geocoder = CLGeocoder()
        
        
        geocoder.reverseGeocodeLocation(location) { (placemarksArray, error) in
            
            if (placemarksArray?.count)! > 0 {
                
                let placemark = placemarksArray?.first
                
                let text = "\(placemark!.locality)"
                
                print(text)
            }
        }
    }
    
    /*
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
        
        let location = locations[0]
        self.currentLocation = location
        
       
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
        
      
        let q = DispatchQueue.global()
        q.async {
            
            
            let geocoder = CLGeocoder()
            
            
            geocoder.reverseGeocodeLocation(location) { (placemarksArray, error) in
                
                if (placemarksArray?.count)! > 0 {
                    
                    let placemark = placemarksArray?.first
                    
                    let text = "\(placemark!.locality)"
                    
                    
                    print(text)
                }
            }
        }
        
        
        
        
    }
 
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
 
        print("Error")
    }*/
    
}

//ThreeHoursCell

extension WeatherViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThreeHoursCell", for: indexPath as IndexPath) as! ThreeHoursCollectionViewCell
        
        let threeHours = threeHoursWeather[indexPath.row]
    
        threeHours.time_zone_id = weather?.timeZoneId
        
        cell.hourLabel.text = threeHours.future_time
        if currentTempUnit == .c{
            cell.tempLabel.text = String.toTemperature(value: String(Int(Double.toCelsius(value: threeHours.temp!))))
        }else{
            cell.tempLabel.text = String.toTemperature(value: String(Int(threeHours.temp!)))
        }
        
        cell.statusLabel.text = threeHours.main
        return cell
    }
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.threeHoursWeather.count
    }
}

//FiveDayForecast
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.fiveDayForecast.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "FiveDayForecastCell", for: indexPath) as! FiveDayForecastCell
        
        
        let index = indexPath.row
        let fiveDay = fiveDayForecast[index]
        cell.dayLabel.text = fiveDay.day_of_the_week
        cell.conditionLabel.text = fiveDay.main
        
        if currentTempUnit == .c{
            let tempMinString = String.toTemperature(value: String(Int(Double.toCelsius(value: fiveDay.temp_min!))))
            let tempMaxString = String.toTemperature(value: String(Int(Double.toCelsius(value: fiveDay.temp_max!))))
            cell.tempRangeLabel.text = "\(tempMinString) - \(tempMaxString)"
        }else{
            let tempMinString = String.toTemperature(value: String(Int(fiveDay.temp_min!)))
            let tempMaxString = String.toTemperature(value: String(Int(fiveDay.temp_max!)))
            cell.tempRangeLabel.text = "\(tempMinString) - \(tempMaxString)"
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension WeatherViewController: WeatherAppDelegate{
    func location(_ location: CLLocation) {
        self.determineLocation(with: location)
    }
    
    func reload(){
        print("reload")
        self.view.reloadInputViews()
        self.tableView.reloadData()
    }
    
    func load(weather: Weather) {
        self.view.reloadInputViews()
        self.tableView.reloadData()
        
    }
    
    func load(weatherModel: WeatherModel) {
        self.view.reloadInputViews()
        self.tableView.reloadData()
        
    }
    
    func remove(at index: Int) {
        
        
    }
}

/*

extension WeatherViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}*/


