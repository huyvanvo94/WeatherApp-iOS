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
    
    fileprivate init(){}
    
    func add(location latlon: LatLon, weatherModels: [WeatherModel]){
        
    }
    
    
    struct ThreeHoursPackage{
    
        var weatherModels: [WeatherModel]
        var timestamp: TimeInterval
        
        init(threehours weatherModels: [WeatherModel]){
            self.weatherModels = weatherModels
            self.timestamp = Date().timeIntervalSince1970
        }
    }
}

class ForecastContainer{
    static let shared = ForecastContainer()
    
    fileprivate init(){}
    
    
    func add(location latlon: LatLon, weatherModel: [WeatherModel]){
        
        
    }
    
}

// container to contain forecast about today
class TodayWeatherContainer{
    static let shared = TodayWeatherContainer()
    
    var dict = [LatLon: TodayWeatherPackage]()
    fileprivate init(){}
    
    // add to dictionary
    func add(location latlon: LatLon, weatherModel: WeatherModel ){
        dict[latlon] = TodayWeatherPackage(today: weatherModel)
    }
    
    // remove from dictionary
    func remove(location latlon: LatLon){
        dict[latlon] = nil
    }
    
    func fetch(with location: LatLon) -> WeatherModel?{
        return dict[location]?.weatherModel
    }
    
    
    struct TodayWeatherPackage{
        var weatherModel: WeatherModel
        var timestamp: TimeInterval
        
        init(today weatherModel: WeatherModel){
            self.weatherModel = weatherModel
            self.timestamp = Date().timeIntervalSince1970
            
        }
        
    }
}




class Cities{

}


class LatLonContainer{
    fileprivate var locations = [LatLon]()
    
    static let shared = LatLonContainer()
    
    fileprivate init(){}
    
    
    func add(location latlon: LatLon!){
        
        locations.append(latlon)
        
    }
    
    func contains(location laton: LatLon) -> Bool{
        return locations.contains(where: {$0 == laton })
    }
    
}
