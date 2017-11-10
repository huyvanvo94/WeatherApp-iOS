//
//  Service.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/8/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

class Event{
    
    
}

protocol ProcessEvent {
    func async_run()
}
// A ViewController needs to implement this
protocol ProcessDelegate {
    func error(event: Event)
    func complete(event: Event)
    
}

// Contains URL for web service
struct ApiFetcher{
    let openWeatherMapKey = "54701ea1287c9e47151bb6be162f1455"
    let googleTimeZoneKey = "AIzaSyD2E7_ssLZXS_SQLlNH6kzBodXkYe6MOhU"
    
    static func fetchTimeZone(googleFormatted location: String){
        let url = "https://maps.googleapis.com/maps/api/timezone/json?location=\(location)&timestamp=\(NSDate().timeIntervalSince1970)&key=AIzaSyD2E7_ssLZXS_SQLlNH6kzBodXkYe6MOhU"
        
        
    }
    static func fetchThreeHours(){
        
    }
    
    static func fetchForecast(){
        
    }
    
    // add function to operation queue
    // func to fetch weather
    static func fetchWeather(latlng location: String, completion: @escaping (Data) -> () ){
        let url = "http://api.openweathermap.org/data/2.5/weather?\(location)&units=imperial&appid=b54f500d4a53fdfc96813a4ba9210417"
        
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
                        
                        
                        
                        if let theData = data{
                            do{
                                let json = try JSONSerialization.jsonObject(with: theData, options: .allowFragments) as! [String: Any]
                                
                                print(json)
                                
                            }catch{
                                
                            }
                            completion(theData)
                        }
                        
                    }
                }
            }
            
            task.resume()
        }
        
        
    }
}
