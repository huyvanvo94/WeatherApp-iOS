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
    
    
    func createCityForecastPage(today: WeatherModel?) -> CityForecastPageController{
        let page = storyboard?.instantiateViewController(withIdentifier: "CityForecastPage") as! CityForecastPageController
        if let _ = today{
          page.today = today!
        }
        
        
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
        let todayWeather = TodayWeatherContainer.shared
    
        if todayWeather.dict.isEmpty{
            let emptyPage = self.createCityForecastPage(today: nil)
            self.pages.append(emptyPage)
            setViewToPage(index: 0)
            return
        }
    
        let operationQueue = OperationQueue()
        
        operationQueue.addOperation {
            
            for(key, data) in todayWeather.dict{
                let weatherModel = data.weatherModel
                
                OperationQueue.main.addOperation {
                    let page = self.createCityForecastPage(today: weatherModel)
                    self.pages.append(page)
                   
                    if self.pages.count == 1{
                        self.setViewToPage(index: 0)
                    }
                }
            }
        }
        
        
        
    }
    
    func loadTodayWeather(){
        
    }

}
