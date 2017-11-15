//
//  WeatherForecastBuilder.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/14/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation


class WeatherForecastBuilder{
    
    var todayWeather: WeatherModel?
    var threeHoursWeather: [WeatherModel]?
    var forecastWeather: [WeatherModel]?
    
    init(todayWeather: WeatherModel, threeHoursWeather: [WeatherModel], forecastWeather: [WeatherModel]) {
        self.todayWeather = todayWeather
        self.threeHoursWeather = threeHoursWeather
        self.forecastWeather = forecastWeather
    }
    
    
    var cityName: String?{
        get{
            return todayWeather?.city
        }
    }
    
    
    
}
