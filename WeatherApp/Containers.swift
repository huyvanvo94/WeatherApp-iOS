//
//  Containers.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

protocol Container{
    
}

class ThreeHoursForecastContainer{
    
    static let shared = ThreeHoursForecastContainer()
    
    private init(){}
    
    func add(location latlon: LatLon, weatherModels: [WeatherModel]){
        
    }
    
    
    struct ThreeHoursPackage{
    
        var weatherModels: [WeatherModel]
        var timestamp: TimeInterval
        
        init(threehours weatherModels: [WeatherModel]){
            self.weatherModels = weatherModels
            self.timestamp = NSDate().timeIntervalSince1970
        }
    }
}

class ForecastContainer{
    static let shared = ForecastContainer()
    
    private init(){}
    
    
    func add(location latlon: LatLon, weatherModel: [WeatherModel]){
        
        
    }
    
}

// container to contain forecast about today
class TodayWeatherContainer{
    static let shared = TodayWeatherContainer()
    
    private var data = [LatLon: WeatherModel]()
    private init(){}
    
    // add to dictionary
    func add(location latlon: LatLon, weatherModel: WeatherModel ){
        data[latlon] = weatherModel
    }
    
    // remove from dictionary
    func remove(location latlon: LatLon ){
        data[latlon] = nil
    }
    
    func fetch(with location: LatLon) -> WeatherModel?{
        return data[location]
    }
    
    
    struct TodayWeatherPackage{
        var weatherModel: WeatherModel
        var timestamp: TimeInterval
        
        init(today weatherModel: WeatherModel){
            self.weatherModel = weatherModel
            self.timestamp = NSDate().timeIntervalSince1970
            
        }
        
    }
}




class Cities{

}


class LatLonContainer{
    private var locations = [LatLon]()
    
    static let shared = LatLonContainer()
    
    private init(){}
    
    
    func add(location latlon: LatLon!){
        
        locations.append(latlon)
        
    }
    
    func contains(location laton: LatLon) -> Bool{
        return locations.contains(where: {$0 == laton })
    }
    
}
