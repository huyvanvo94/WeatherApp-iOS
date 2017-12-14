//
//  NavigationViewController.swift
//  WeatherApp
//
//  Created by Huy Vo on 12/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = UIColor(rgb: 0x4286f4)
        
        let textAttributes = [NSForegroundColorAttributeName:UIColor.white]
        
        self.navigationBar.titleTextAttributes = textAttributes
       
        self.goToListView()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func goToListView(){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddCityViewController") as? AddCityViewController {
            
            self.pushViewController(vc, animated: true)
        }
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
