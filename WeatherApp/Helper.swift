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

// parse json to models
struct JsonParser{
    static func parseThreeHours( data: Data) -> [WeatherModel]? {
        do{
            var weatherModels = [WeatherModel]()
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
        
            let weatherJSONArray = json["list"] as! NSArray
            let length = weatherJSONArray.count
        
            for i in 0 ..< length{
                let weatherModel = WeatherModel()
                
                let weatherJsonObject = weatherJSONArray[i] as! [String: Any]
                
                weatherModel.dt = weatherJsonObject["dt"] as? Double
                
                let mainObject = weatherJsonObject["main"] as! [String: Any]
                
                weatherModel.temp_max = mainObject["temp_max"] as? Double
                weatherModel.temp_min = mainObject["temp_min"] as? Double
                weatherModel.temp = mainObject["temp"] as? Double
              
                let weatherInfo = ((weatherJsonObject["weather"] as! NSArray)[0]) as! [String: Any]
                weatherModel.main = weatherInfo["main"] as? String
                weatherModel.weather_description = weatherInfo["description"] as? String
                weatherModel.icon = weatherInfo["icon"] as? String
                
                weatherModels.append(weatherModel)
            }
            
            return weatherModels
        }
        catch{
            return nil
        }
    }

    static func parseWeather(today data: Data) -> WeatherModel?{
        print("parse today weather data")
        do{
            let weatherModel = WeatherModel()
            
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
      
            
            weatherModel.dt = json["dt"] as? Double
            
            let weatherInfo = ((json["weather"] as! NSArray)[0]) as! [String: Any]
            
            weatherModel.main = weatherInfo["main"] as? String
            weatherModel.icon = weatherInfo["icon"] as? String
            weatherModel.weather_description = weatherInfo["description"] as? String
            
            let mainObject = json["main"] as! [String: Any]
            
            weatherModel.temp_max = mainObject["temp_max"] as? Double
            weatherModel.temp_min = mainObject["temp_min"] as? Double
            weatherModel.pressure = mainObject["pressure"] as? Double
            weatherModel.humidity = mainObject["humidity"] as? Double
            weatherModel.temp = mainObject["temp"] as? Double
            
            let windObject = json["wind"] as! [String: Any]
            weatherModel.wind_speed = windObject["speed"] as? Double
            
            
            let sysObject = json["sys"] as! [String: Any]
            
            weatherModel.country = sysObject["country"] as? String
            weatherModel.city = sysObject["name"] as? String
            
            let coord = json["coord"] as! [String: Any]
            weatherModel.lat = coord["lat"] as? Double
            weatherModel.lng = coord["lon"] as? Double
        
            return weatherModel
        }catch{
           return nil
        }
        
        
    }
    
    
    static func parseForecast( data: Data) -> [WeatherModel]?{
    
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
          
            var weatherModels = [WeatherModel]()
            
            let weatherNSArray = json["list"] as! NSArray
            let length = weatherNSArray.count
            
            for i in 1..<length{
                let weatherModel = WeatherModel()
                
                let weatherJSONObject = weatherNSArray[i] as! [String: Any]
                
                weatherModel.dt = weatherJSONObject["dt"] as? Double
                
                weatherModel.pressure = weatherJSONObject["pressure"] as? Double
                weatherModel.humidity = weatherJSONObject["humidity"] as? Double
                weatherModel.wind_speed = weatherJSONObject["speed"] as? Double
                weatherModel.degree = weatherJSONObject["deg"] as? Double
                
                let tempJSONObject = weatherJSONObject["temp"] as! [String: Any]
                
                weatherModel.temp_max = tempJSONObject["max"] as? Double
                weatherModel.temp_min = tempJSONObject["min"] as? Double
                weatherModel.temp_day = tempJSONObject["day"] as? Double
                weatherModel.temp_night = tempJSONObject["night"] as? Double
                weatherModel.temp_eve = tempJSONObject["eve"] as? Double
                weatherModel.temp_morn = tempJSONObject["morn"] as? Double
                
                let weatherInfo = ((weatherJSONObject["weather"] as! NSArray)[0]) as! [String: Any]
                
                
                weatherModel.main = weatherInfo["main"] as? String
                weatherModel.weather_description = weatherInfo["description"] as? String
                weatherModel.icon = weatherInfo["icon"] as? String
                
                weatherModels.append(weatherModel)
            }
        
            
            return weatherModels
        }catch{
            return nil
            
        }
    }
    
    static func parseTime(data: Data) -> TimeModel?{
        print("parseTime")
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
