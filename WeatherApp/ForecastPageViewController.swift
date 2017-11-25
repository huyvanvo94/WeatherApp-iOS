
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ForecastPageView viewDidLoad")
        
        print("ForecastPageView \(pages.count)")
        
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
        
        let app = UIApplication.shared.delegate as! AppDelegate
        let index = app.index
        
        let queue = LoadWeatherQueue(vc: self, index: index)
        queue.asyncStart()
        
        
    }
    
    
}

