
//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/10/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//
import UIKit

class ForecastPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, WeatherAppDelegate {
    
    lazy var settingButton: UIButton = {
        
        let button = UIButton()
        
        return button
    }()
    
    var index: Int = -1
    
    var weatherModels = [WeatherModel]()
    var pages = [UIViewController]()
   
    func load(weather: Weather){
        print("fvc load")
   
        self.weatherModels.append(weather.todayWeather)
        self.pages.append(self.createCityForecastPage(weather: weather))
        
        if self.weatherModels.count - 1 == self.index{
            self.setViewToPage(index: self.index)
        }else if self.weatherModels.count == WeatherApp.shared.places.count{
            self.setViewToPage(index: 0)
        }
    }
    
    func load(weatherModel: WeatherModel){
        
    }
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")

        if WeatherApp.shared.places.isEmpty{
          
            let emptyPage = self.createCityForecastPage(weather: nil)
            self.pages.append(emptyPage)
            setViewToPage(index: 0)
        }else{
 
            WeatherApp.shared.add(delegate: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
        
        WeatherApp.shared.remove(delegate: self)
    }


    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("viewDidAppear")


    }

    func setViewToPage(index: Int){
        guard index >= 0 && index < pages.count else{
            return
        }
        
        setViewControllers([pages[index]], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
    }
    
    
    func createCityForecastPage(weather: Weather?) -> WeatherViewController {
        let page = storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        
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
  
    
}

