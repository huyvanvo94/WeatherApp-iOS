//
//  Event.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

protocol WeatherEvent {
    func asyncFetch()
}

class EventQueue{
    
}

class FetchThreeHoursForecastEvent{
    
    let city: String
    let latlon: LatLon
    
    init(city: String, latlon: LatLon){
        self.city = city
        self.latlon = latlon
        
    }
    
    func asyncFetch(completion: ( ([WeatherModel]) -> () )?){
        let queue = OperationQueue()
        queue.addOperation {
            let location = self.latlon.openWeatherLocation
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
            let location = self.latlon.openWeatherLocation
            
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

// event to event today's weather
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
            let location = self.latlon.openWeatherLocation
                
            ApiService.fetchWeather(latlng: location, completion:
                {(weatherModel: WeatherModel) -> Void in
                    
                    
                    weatherModel.city = self.city
             
                    let location = self.latlon.googleLocation
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
