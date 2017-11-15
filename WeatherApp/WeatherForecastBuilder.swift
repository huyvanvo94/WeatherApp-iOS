//
//  WeatherForecastBuilder.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/14/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation


class WeatherForecastBuilder{
    
    let todayWeather: WeatherModel
    let threeHoursWeather: [WeatherModel]
    let forecastWeather: [WeatherModel]
    
    init(todayWeather: WeatherModel, threeHoursWeather: [WeatherModel], forecastWeather: [WeatherModel]) {
        self.todayWeather = todayWeather
        self.threeHoursWeather = threeHoursWeather
        self.forecastWeather = forecastWeather
    }
    
    
    var cityName: String?{
        get{
            return todayWeather.city
        }
    }
    
    
    
}
