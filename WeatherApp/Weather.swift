//
//  Weather.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/3/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

struct LatLon{
    var lat: Double!
    var lon: Double!
}

class WeatherModel: NSObject{
    
    var dt: UInt64?
    
    var humidity: Int?
    var pressure: Int?
    
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

    var country: String?
    var city: String?
    var weather_description: String?
    var time_zone_id: String?
    
    // Time logistics
    
    //TODO: Update this function
    var local_time: String{
        get{
            let unix_time = NSDate().timeIntervalSince1970 * 1000
            
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
/**
 * A simple class to contain weather data
 */
class WeatherContainer{
    
    
}


