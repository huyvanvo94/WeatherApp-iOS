//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/10/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
 
    var weather: Weather?
    
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CityForecastPageController viewDidLoad")
    
        
 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadToView()
    }
 

    func loadToView(){
        
        if let weather = self.weather{
            
            if let city = weather.city{

                cityLabel.sizeToFit()
                cityLabel.text = city
                cityLabel.adjustsFontSizeToFitWidth = true
                cityLabel.textAlignment = .center
            }

        }else{
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func determineLocation(with location: CLLocation){
        let geocoder = CLGeocoder()
        
        
        geocoder.reverseGeocodeLocation(location) { (placemarksArray, error) in
            
            if (placemarksArray?.count)! > 0 {
                
                let placemark = placemarksArray?.first
                
                let text = "\(placemark!.locality)"
                
                
                print(text)
            }
        }
    }
    
    /*
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
        
        let location = locations[0]
        self.currentLocation = location
        
       
        print(location.coordinate.latitude)
        print(location.coordinate.longitude)
        
      
        let q = DispatchQueue.global()
        q.async {
            
            
            let geocoder = CLGeocoder()
            
            
            geocoder.reverseGeocodeLocation(location) { (placemarksArray, error) in
                
                if (placemarksArray?.count)! > 0 {
                    
                    let placemark = placemarksArray?.first
                    
                    let text = "\(placemark!.locality)"
                    
                    
                    print(text)
                }
            }
        }
        
        
        
        
    }
 
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
 
        print("Error")
    }*/
    
}
