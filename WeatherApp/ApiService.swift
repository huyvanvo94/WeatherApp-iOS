//
//  ApiService.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation


struct ApiService{
    static let openWeatherMapKey = "54701ea1287c9e47151bb6be162f1455"
    static let googleTimeZoneKey = "AIzaSyD2E7_ssLZXS_SQLlNH6kzBodXkYe6MOhU"
    
    static func fetchTimeZone(googleFormatted location: String, completion: ((TimeModel) -> () )?){
        print("fetchTimeZone")
        let url = "https://maps.googleapis.com/maps/api/timezone/json?location=\(location)&timestamp=\(NSDate().timeIntervalSince1970)&key=\(googleTimeZoneKey)"
        
        print("url: \(url)")
        
        let requestURL = URL(string: url)
        
        if let theRequestURL = requestURL{
            let urlRequest = URLRequest(url: theRequestURL)
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest){
                (data, response, error) -> Void in
                print("Api Fetcher task")
                if let theHttpResponse = response as? HTTPURLResponse{
                    // request has been successful
                    if theHttpResponse.statusCode == 200 {
                        
                        
                        if let data = data{
                            if let timeModel = JsonParser.parseTime(data: data){
                                if let completion = completion{
                                    completion(timeModel)
                                }
                            }
                        }
                    }
                }
            }
            
            task.resume()

        }
    }
    static func fetchThreeHours(latlng location: String, completion: (([WeatherModel]) -> () )?){
        let url = "http://api.openweathermap.org/data/2.5/forecast?\(location)&mode=json&units=imperial&cnt=8&appid=\(openWeatherMapKey)"
        
        let requestURL = URL(string: url)
        
        if let theRequestURL = requestURL{
            let urlRequest = URLRequest(url: theRequestURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest){
                (data, response, error) -> Void in
           
                if let httpResponse = response as? HTTPURLResponse{
                    // request has been successful
                    if httpResponse.statusCode == 200 {
                        
                        if let data = data{
                            if let weatherModels = JsonParser.parseThreeHours(data: data){
                                if let completion = completion{
                                    completion(weatherModels)
                                }
                            }
                            
                        }
                        
                    }
                }
            }
            
            task.resume()
        }

    }
    
    static func fetchForecast(latlng location: String, completion: (([WeatherModel]) -> () )?){
        let url = "http://api.openweathermap.org/data/2.5/forecast/daily?\(location)&mode=json&units=imperial&cnt=7&appid=\(openWeatherMapKey)"
        
        let requestURL = URL(string: url)
        
        if let theRequestURL = requestURL{
            let urlRequest = URLRequest(url: theRequestURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest){
                (data, response, error) -> Void in
                print("Api Fetcher task")
                if let httpResponse = response as? HTTPURLResponse{
                    // request has been successful
                    if httpResponse.statusCode == 200 {
                        
                        if let data = data{
                            if let weatherModels = JsonParser.parseForecast(data: data){
                                if let completion = completion{
                                    completion(weatherModels)
                                }
                            }
                            
                        }
                        
                    }
                }
            }
            
            task.resume()
        }

        
    }
    
    // add function to operation queue
    // func to fetch weather
    static func fetchWeather(latlng location: String, completion: ((WeatherModel) -> () )?){
        let url = "http://api.openweathermap.org/data/2.5/weather?\(location)&units=imperial&appid=\(openWeatherMapKey)"
        
        let requestURL = URL(string: url)
        
        if let theRequestURL = requestURL{
            let urlRequest = URLRequest(url: theRequestURL)
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest){
                (data, response, error) -> Void in
                print("Api Fetcher task")
                if let theHttpResponse = response as? HTTPURLResponse{
                    // request has been successful
                    if theHttpResponse.statusCode == 200 {
                        
                        if let data = data{
                            if let weatherModel = JsonParser.parseWeather(data: data){
                                if let completion = completion{
                                    completion(weatherModel)
                                }
                          
                            }
                            
                        
                        }
                        
                    }
                }
            }
            
            task.resume()
        }
        
        
    }
}
