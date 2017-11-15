//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/10/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import UIKit

class ForecastPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var pages = [UIViewController]()
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ForecastPageView viewDidLoad")
  
        print("ForecastPageView \(pages.count)")
        if let _ = index{
            print("ForecastPageView \(index!)")
        }
        
        self.delegate = self
        self.dataSource = self

        asyncLoadDataToUI()
        
    }
    
    func setViewToPage(index: Int){
        guard index >= 0 && index < pages.count else{
            return
        }
        
        setViewControllers([pages[index]], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
    }
    
    
    func createCityForecastPage(weatherBuilder: WeatherForecastBuilder?) -> CityForecastPageController{
        let page = storyboard?.instantiateViewController(withIdentifier: "CityForecastPage") as! CityForecastPageController
        
        print("Weather Builder City: \(weatherBuilder?.cityName)")
        page.weatherBuilder = weatherBuilder
        
        return page
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
 
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController)-> UIViewController? {
        
        let cur = pages.index(of: viewController)!
        
        if cur == 0 { return nil }
        
        let prev = abs((cur - 1) % pages.count)
        return pages[prev]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController)-> UIViewController? {
        
        let cur = pages.index(of: viewController)!
        
        // if you prefer to NOT scroll circularly, simply add here:
        if cur == (pages.count - 1) { return nil }
        
        let nxt = abs((cur + 1) % pages.count)
        return pages[nxt]
    }
    
    func presentationIndex(for pageViewController: UIPageViewController)-> Int {
        return pages.count
    }
    
    func emptyPage(){
        
    }

    // load weather data to UI
    func asyncLoadDataToUI(){
        
        print("asyncLoaDataToUI")
        
        let todayWeather = TodayWeatherContainer.shared
    
        // if is empty, UI needs to tell user that currently containers no weather
        if todayWeather.dict.isEmpty{
        
            let emptyPage = self.createCityForecastPage(weatherBuilder: nil)
            self.pages.append(emptyPage)
            setViewToPage(index: 0)
            return
        }
  
        
        let operationQueue = OperationQueue()
        
        operationQueue.addOperation {
            
            for(key, data) in todayWeather.dict{
                
                let today: WeatherModel = data.weatherModel
                
                guard let threeHours: [WeatherModel] = ThreeHoursForecastContainer.shared.fetch(with: key), let forecast: [WeatherModel] = ForecastContainer.shared.fetch(with: key) else{
                   
                    continue
                }
                
                let weatherBuilder = WeatherForecastBuilder(todayWeather: today, threeHoursWeather: threeHours, forecastWeather: forecast)
               
                OperationQueue.main.addOperation {
                    print(weatherBuilder.cityName)
                    
                    let page = self.createCityForecastPage(weatherBuilder: weatherBuilder)
                   
                    self.pages.append(page)
                    
                    if self.pages.count == self.index! + 1{
                        self.setViewToPage(index: self.index!)
                    }

                }
                
                
                
            }
          
        }
        
        
        
    }
    
    func loadTodayWeather(){
        
    }

}
