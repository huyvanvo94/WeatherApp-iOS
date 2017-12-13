//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

class WeatherModel: Equatable{
    
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
    
    var day_of_the_week: String?{
        get{
            if let _ = time_zone_id{
                if let _  = dt{
                    return DateHelper.getDayOfWeek(dt: dt!, timeZoneId: time_zone_id!)
                }
            }
            
            return nil
        }
    }
    
    var local_date: String?{
        get{
            if let _ = time_zone_id{
                if let _ = dt{
                    return DateHelper.getLocalDate(dt: dt!, timeZoneId: time_zone_id!)
                }
            }
            
            return nil
        }
    }
    
    var future_time: String?{
        get{
            if let _ = time_zone_id{
                if let _ = dt{
                    return DateHelper.getLocalTime(dt: dt!, timeZoneId: time_zone_id!)
                }
            }
            return nil
        }
    }
    
    var local_time: String{
        get{ 
            return DateHelper.getLocalTime(dt: Date().timeIntervalSince1970, timeZoneId: TimeZone.current.identifier)
        }
    }
    
    
    static func == (lhs: WeatherModel, rhs: WeatherModel) -> Bool {
        return lhs.city == rhs.city && lhs.lng == rhs.lng && lhs.lat == rhs.lat
    }
    
  
 

    
}

