//
// Created by Huy Vo on 12/8/17.
// Copyright (c) 2017 Huy Vo. All rights reserved.
//

import Foundation
import CoreLocation

var currentTempUnit: Temperature = .f

final class WeatherApp: NSObject, CLLocationManagerDelegate {
    fileprivate var fetchLocation = false
    
    private var delegates = [WeatherAppDelegate]()

    lazy var locationManager: CLLocationManager = {
        let locman = CLLocationManager()
        locman.delegate = self
        locman.distanceFilter = 200
        locman.desiredAccuracy = kCLLocationAccuracyBest
        return locman
    }()
    
    var location: CLLocation?
    var delegate: WeatherAppDelegate?
    var places = [Place]()
    
    private var _today = [Place: WeatherModel]()
    private var _three = [Place: [WeatherModel]]()
    private var _forecast = [Place: [WeatherModel]]()

    static let shared = WeatherApp()

    override private init (){
        
        print("WeatherApp Constructor")
        super.init()
         
        self.locationManager.requestAlwaysAuthorization()
       
        self.requestLocation()
      
        self.locationManager.startMonitoringSignificantLocationChanges()
        
     //   self.fetchCurrentLocation()
        
    }
    
    func stopLocationService(){
        self.locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    func fetchCurrentLocation(){
        print("fetch")
     
        self.fetchLocation = true
        self.locationManager.requestLocation()
        
    }
    
    func determineLocation(with location: CLLocation){
        print("determineLocation")
        let geocoder = CLGeocoder()
        
        
        geocoder.reverseGeocodeLocation(location) { (placemarksArray, error) in
            
            if (placemarksArray?.count)! > 0 {
                
                let placemark = placemarksArray?.first
                
                let text = "\(placemark!.locality)"
                
                
                if let city = placemark?.locality{
                    print("City: \(city)")
                    let place = Place(city: city, longitude: location.coordinate.longitude as Double, latitude: location.coordinate.latitude as Double)
                    
                    self.addPlace(place)
                }
            }
        }
    }
    
    func reloadDelegates(){
        print("reload delegates")
        DispatchQueue.global().async {
            
            for delegate in self.delegates{
                delegate.reload()
            }
        }
    }
    
    func requestLocation(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            self.locationManager.requestLocation()
        }else if CLLocationManager.authorizationStatus() == .authorizedAlways{
             self.locationManager.requestLocation()
        }
    }
    
    func delete(at index: Int){
        if index < 0 || index > places.count{
            return
        }
       
        let place = self.places[index]
        self.delete(place: place)
        
        // notify listeners
        DispatchQueue.main.async {
            for delegate in self.delegates{
                delegate.remove(at: index)
            }
        }
    }
    
    private func delete(place: Place){
        if let index = places.index(of: place ){
            places.remove(at: index)
        }
        
        self._today[place] = nil
        self._three[place] = nil
        self._forecast[place] = nil
        
        self.save()
        
     
        
      //  self.updateListeners()
    }
    
    func addPlace(_ place: Place){
        if self.places.contains(where: {$0.city == place.city }){
            return
        }
  
        places.append(place)
        self.save()
        self.fetchWeather(place: place)
        self.fetchForecast(place: place)
        self.fetchThreeHours(place: place)
    }
    
    private func fetchWeather(place: Place){
        let queue = DispatchQueue.global()
        
        queue.async{
            // string format for weather
            let location = place.openWeatherLocation
            
            ApiService.fetchWeather(latlng: location, completion:
                {(weatherModel) -> Void in
                    
                    weatherModel.city = place.city
                    weatherModel.lat = place.latitude
                    weatherModel.lng = place.longitude
                    
                    let location = place.googleLocation
                    ApiService.fetchTimeZone(googleFormatted: location, completion: {
                        (timeModel) in
                       
                        weatherModel.time_zone_id = timeModel.timeZoneId
                       
                        self._today[place] = weatherModel
                        
                        self.updateListeners()
                    })
            })
        }
    }
    
    private func fetchThreeHours(place: Place){
        
        let queue = DispatchQueue.global()
        
        queue.async{
            let location = place.openWeatherLocation
            ApiService.fetchThreeHours(latlng: location, completion: {
                (weatherModels) in
                self._three[place] = weatherModels
            })
        }
    }
 
    private func fetchForecast(place: Place){
        let queue = DispatchQueue.global()
        queue.async{
            // string format for weather
            let location = place.openWeatherLocation
            
            ApiService.fetchForecast(latlng: location, completion: {
                (weatherModels) in
                
                self._forecast[place] = weatherModels
                
            })
        }
    }
    
  
    func updateListeners(){
        print("updateListeners")
        let queue = DispatchQueue.global()
        queue.async{
            
            for place in self.places{
             
                if let today = self._today[place] {
                   
                    for delegate in self.delegates{
                        DispatchQueue.main.async {
                            delegate.load(weatherModel: today)
                          
                            
                         
                        }
                        
                        DispatchQueue.main.async {
                            if let three = self._three[place]{
                                if let forecast = self._forecast[place]{
                                    let weather = Weather(todayWeather: today, threeHoursWeather: three, forecastWeather: forecast)
                                
                                    delegate.load(weather: weather)
                                }
                            }
                            
                        }
                    }
                }
            }
        }
    }

    public func remove(delegate: WeatherAppDelegate){
        if let index = delegates.index(where: { $0 === delegate }) {
            delegates.remove(at: index)
        }
    }

    public func add(delegate: WeatherAppDelegate){
        delegates.append(delegate)
        self.updateListeners()
    }
    public func delete(){
      /*
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "places")
        */
        
    }
 
    public func save(){
        /*
        print("WeatherApp save")
        let savedData = NSKeyedArchiver.archivedData(withRootObject: self.places)
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "places")
 */
        
    }
    
    public func load(){
        /*
        print("WeatherApp load")
        let defaults = UserDefaults.standard
        
        if let savedPlaces = defaults.object(forKey: "places") as? Data {
            self.places = NSKeyedUnarchiver.unarchiveObject(with: savedPlaces) as! [Place]
        
            for place in self.places{
                self.fetchWeather(place: place)
                self.fetchForecast(place: place)
                self.fetchThreeHours(place: place)
            }
        }
        */
     
    }
 
    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
     
            let location = locations[0]
            
            self.location = location
            
            DispatchQueue.global().async {
                for delegate in self.delegates{
                    delegate.location(location)
                }
            }
            
            if self.fetchLocation{
                
                self.determineLocation(with: location)
                self.fetchLocation = false
            }
     
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       
    }
    
}

struct Weather{
    
    var todayWeather: WeatherModel
    var threeHoursWeather: [WeatherModel]
    var forecastWeather: [WeatherModel]
    
    init(todayWeather: WeatherModel, threeHoursWeather: [WeatherModel], forecastWeather: [WeatherModel]) {
        self.todayWeather = todayWeather
        self.threeHoursWeather = threeHoursWeather
        self.forecastWeather = forecastWeather
        
    }
    
    var city: String?{
        return todayWeather.city
    }
    
    var timeZoneId: String?{
        return todayWeather.time_zone_id
    }
    
    static func ==(lhs: Weather, rhs: Weather) -> Bool {
        
        return lhs.todayWeather == rhs.todayWeather
    }
     
}

protocol WeatherAppDelegate: class{
    func reload()
    
    func load(weather: Weather)
    func load(weatherModel: WeatherModel) 
    func remove(at index: Int)
    
    func location(_ location: CLLocation)

}



