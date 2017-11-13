//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/10/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import UIKit

class CityForecastPageController: UIViewController {

    // weather model cannot be null
    var today: WeatherModel!
    
    @IBOutlet weak var cityName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("CityForecastPageController viewDidLoad")
 
        //cityName.text = weatherModel.city
        
        self.view.backgroundColor = UIColor.blue
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
