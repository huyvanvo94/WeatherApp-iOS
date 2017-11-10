//
//  Helper.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/8/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

 

struct Tester{
    static let latlng = "lat=37.7652065&lon=-122.2416355"
}

struct JsonHelper{
    
}

// parse json to models
struct JsonParser{
    static func parseThreeHoursWeather() -> Array<WeatherModel> {
        let weatherModels = [WeatherModel]()
        
        return weatherModels
    }

    static func parseWeather(json: [String: Any] ) -> WeatherModel{
        
        let weather = WeatherModel()
        
        return weather
    }
    
    
    static func parseForecast( ) -> Array<WeatherModel>{
    
        let weatherModels = [WeatherModel]()
        
        return weatherModels
    }
    
    
}
