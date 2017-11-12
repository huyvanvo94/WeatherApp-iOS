//
//  Event.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

class FetchThreeHoursForecastEvent{
    
    let city: String
    let latlon: LatLon
    
    init(city: String, latlon: LatLon){
        self.city = city
        self.latlon = latlon
        
    }
    
    func asyncFetch(completion: (  ([WeatherModel]) -> () )?){
        let queue = OperationQueue()
        queue.addOperation {
            let location = "lat=\(self.latlon.latitude)&lon=\(self.latlon.longitude)"
            ApiService.fetchThreeHours(latlng: location, completion: {
                (weatherModels: [WeatherModel]) -> Void in
                
                
                if let completion = completion{
                    completion(weatherModels)
                }
            })
        }
    }
}

class FetchForecastEvent{
    let city: String
    let latlon: LatLon
    
    init(city: String, latlon: LatLon){
        self.city = city
        self.latlon = latlon
    }
 
    
    func asyncFetch(completion: (  ([WeatherModel]) -> () )?){
        
        let queue = OperationQueue()
        queue.addOperation {
            // string format for weather
            let location = "lat=\(self.latlon.latitude)&lon=\(self.latlon.longitude)"
            
            ApiService.fetchForecast(latlng: location, completion: {
                (weatherModels: [WeatherModel]) -> Void in
                print("Finish fetching forecast")

                
                if let completion = completion{
                    completion(weatherModels)
                }
                
            })
            
        }
    }
 


    
}


class FetchWeatherEvent{
    
    let city: String
    let latlon: LatLon
    
    init(city: String, latlon: LatLon){
        self.city = city
        self.latlon = latlon
    }
    
    func asyncFetch(completion: ((WeatherModel) -> () )?){
        
        let queue = OperationQueue()
        queue.addOperation {
        
            // string format for weather
            let location = "lat=\(self.latlon.latitude)&lon=\(self.latlon.longitude)"
            ApiService.fetchWeather(latlng: location, completion:
                {(weatherModel: WeatherModel) -> Void in
                    print("Complete fetching weather")
                    
                    weatherModel.city = self.city
                    
                    let location = "\(self.latlon.latitude),\(self.latlon.longitude)"
                    ApiService.fetchTimeZone(googleFormatted: location, completion: {
                        (timeModel: TimeModel) -> Void in
                        weatherModel.time_zone_id = timeModel.timeZoneId
                        
                        if let completion = completion{
                            
                            completion(weatherModel)
                        }
                    
                    })
                    
                    
            })
            
        }
      
    
    }
}

enum FetchError: Error{
    
}
