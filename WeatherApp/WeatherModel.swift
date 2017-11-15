//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

class WeatherModel: NSObject, Codable{
    // maybe i should change data type
    var dt: Double?
    
    var humidity: Double?
    var pressure: Double?
    
    var wind_speed: Double?
    
    var temp_max: Double?
    var temp_min: Double?
    var temp: Double?
    var temp_day: Double?
    var temp_night: Double?
    var temp_eve: Double?
    var temp_morn: Double?
    
    var lat: Double?
    var lng: Double?
    
    var location: String?
    var degree: Double? 
    var country: String?
    var city: String?
    var weather_description: String?
    var time_zone_id: String?
    
    var main: String?
    
    var icon: String?
    
    // Time logistics
    
    //TODO: Update this function
    var local_time: String{
        get{
            let unix_time = Date().timeIntervalSince1970 * 1000
            
            return String(unix_time)
        }
    }
    
    
    var day_of_the_week: String{
        get{
            return "TODO"
        }
    }
    
    var local_date: String{
        get{
            return "TODO"
        }
    }
    
    var future_time: String{
        get{
            return "TODO"
        }
    }
    
    // a variable to print out about class
    override var description: String{
        return ""
    }
}

class ThreeHoursModel: WeatherModel{
    
}

class ForecastModel: WeatherModel{
    
}

class TodayWeatherModel: WeatherModel{
    
}
