//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/10/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import UIKit

class CityForecastPageController: UIViewController {

    var weather: Weather?
    
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CityForecastPageController viewDidLoad")
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
