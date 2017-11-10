//
//  ViewController.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/3/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController, UIPageViewControllerDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ViewController viewDidLoad")
        asyn_fetch()
        
        
    }
    
    func asyn_fetch(){
        let queue = OperationQueue()
        queue.addOperation {
            
            ApiFetcher.fetchWeather(latlng: "lat=37.7652065&lon=-122.2416355",
                                   completion: {(data: Data) -> Void in
                                                        print(data)})
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    
 
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        return nil
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        
        return nil
        
    }
    
}

