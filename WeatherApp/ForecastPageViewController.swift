
//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/10/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//
import UIKit

class ForecastPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, WeatherAppDelegate {
    
    var pages = [UIViewController]()
   
    func loadWeather(weather: WeatherModel) {
        
    }
    
    func load(weather: WeatherModel) {
        
    }
    
    func loadTodayWeather(weatherModels: [WeatherModel]) {
        
    }
    
    func load(weather: Weather){
        self.pages.append(self.createCityForecastPage(weather: weather)) 
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        asyncLoadDataToUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        WeatherApp.shared.add(delegate: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        WeatherApp.shared.remove(delegate: self)
    }
    
    func setViewToPage(index: Int){
        guard index >= 0 && index < pages.count else{
            return
        }
        
        setViewControllers([pages[index]], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
    }
    
    
    func createCityForecastPage(weather: Weather?) -> CityForecastPageController{
        let page = storyboard?.instantiateViewController(withIdentifier: "CityForecastPage") as! CityForecastPageController
        
        page.weather = weather
        
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
            
            let emptyPage = self.createCityForecastPage(weather: nil)
            self.pages.append(emptyPage)
            setViewToPage(index: 0)
            return
        }
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let index = app.index
     
        
    }
    
    
}

