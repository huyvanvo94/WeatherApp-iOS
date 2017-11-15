//
//  LoadWeatherQueue.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/14/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation
class LoadWeatherQueue{
    
    var queue = LatLonContainer.shared.locations
    
    let vc: ForecastPageViewController!
    let index: Int!
    var count = 0
    init(vc: ForecastPageViewController, index: Int){
        self.vc = vc
        self.index = index
    }
    
    private func fetchData(){
        if queue.isEmpty{
            return
        }
        
        let key = queue.removeFirst()
        
        let today = TodayWeatherContainer.shared.fetch(with: key)
        let threeHours = ThreeHoursForecastContainer.shared.fetch(with: key)
        let forecast = ForecastContainer.shared.fetch(with: key)
        
        
        let weatherBuilder = WeatherForecastBuilder(todayWeather: today!, threeHoursWeather: threeHours!, forecastWeather: forecast!)
        
        postNextToUI(weatherBuilder: weatherBuilder)
        
        
    }
    
    func postNextToUI(weatherBuilder: WeatherForecastBuilder){
        OperationQueue.main.addOperation {
            let page = self.vc.createCityForecastPage(weatherBuilder: weatherBuilder)
            
            self.vc.pages.append(page)
                        if self.count != -1{
                if self.count == self.index{
                    self.vc.setViewToPage(index: self.index)
                    self.count = -1
                }else{
                    self.count += 1
                }
            }
            
            
            
            self.fetchData()
        }
        
    }
    
    func asyncStart(){
        
        let queue = OperationQueue()
        queue.addOperation {
            
            self.fetchData()
        }
        
        
    }
}
