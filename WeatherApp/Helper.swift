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

    static func parseWeather(data: Data) -> WeatherModel?{
        
        do{
            let weather = WeatherModel()
            
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
     
            if let coord = json["coord"] as? NSDictionary{
                if let lat = coord["lat"] as? Double{
                    weather.lat = lat
                }
                
                if let lon = coord["lon"] as? Double{
                    weather.lng = lon
                }
            }
        
            return weather
        }catch{
           return nil
        }
        
        
    }
    
    
    static func parseForecast(data: Data) -> [WeatherModel]?{
    
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
            print(json)
            let weatherModels = [WeatherModel]()
        
            
            return weatherModels
        }catch{
            return nil
            
        }
    }
    
    static func parseTime(data: Data) -> TimeModel?{
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
          
            let model = TimeModel()
            
            if let timeZoneId = json["timeZoneId"] as? String{
                model.timeZoneId = timeZoneId
            }
            
            if let rawOffSet = json["rawOffset"] as? Int{
                model.rawOffset = rawOffSet
            }
            
            return model
            
        }catch{
            return nil
        }
        
    }
    
    
}
