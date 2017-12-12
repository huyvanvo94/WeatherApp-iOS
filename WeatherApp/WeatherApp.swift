//
// Created by Huy Vo on 12/8/17.
// Copyright (c) 2017 Huy Vo. All rights reserved.
//

import Foundation
import CoreLocation

final class WeatherApp: NSObject, CLLocationManagerDelegate {
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
    }
    
    func requestLocation(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            self.locationManager.requestLocation()
            
        }
    }
    
    func delete(place: Place){
        self._today[place] = nil
        self._three[place] = nil
        self._forecast[place] = nil
        
      //  self.updateListeners()
    }
    
    func addPlace(_ place: Place){
    
        if places.doContains(obj: place){
            return
        }else{
            places.append(place)
            self.fetchWeather(place: place)
            self.fetchForecast(place: place)
            self.fetchThreeHours(place: place)
        }
        
    }
    
    private func fetchWeather(place: Place){
        let queue = DispatchQueue.global()
        
        queue.async{
            // string format for weather
            let location = place.openWeatherLocation
            
            ApiService.fetchWeather(latlng: location, completion:
                {(weatherModel: WeatherModel) -> Void in
                    
                    weatherModel.city = place.city
                    weatherModel.lat = place.latitude
                    weatherModel.lng = place.longitude
                    
                    let location = place.googleLocation
                    ApiService.fetchTimeZone(googleFormatted: location, completion: {
                        (timeModel: TimeModel) -> Void in
                       
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
                (weatherModels: [WeatherModel]) -> Void in
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
                (weatherModels: [WeatherModel]) -> Void in
                
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
        
    }
 
    public func save(){
        print("WeatherApp save")
        let savedData = NSKeyedArchiver.archivedData(withRootObject: self.places)
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "places")
    }
    
    public func load(){
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
         
    }
 
    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        print(locations)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       
    }
    
}

class Weather: NSObject, Codable{
    
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
    
    static func ==(lhs: Weather, rhs: Weather) -> Bool {
        
        return lhs.todayWeather.hashValue == rhs.todayWeather.hashValue
    }
    
    
    
}

@objc protocol WeatherAppDelegate: class{
    func load(weather: Weather)
    func load(weatherModel: WeatherModel)
    
    @objc optional func foo()
    
    
}



