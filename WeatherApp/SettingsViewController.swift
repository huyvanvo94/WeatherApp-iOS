//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by student on 12/16/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController{
    
    
    @IBOutlet weak var settingsSwitch: UISegmentedControl!
    
    
    override func loadView() {
        super.loadView()
     
        print("loadView")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        
        switch currentTempUnit{
        case .c:
            settingsSwitch.selectedSegmentIndex = 1
        case .f:
            settingsSwitch.selectedSegmentIndex = 2
        }
        
    }
    
    //MARK- Actions
    @IBAction func settingsSwitchChanged(_ sender: UISegmentedControl) {
        print("settingsSwitchChanged")
        currentTempUnit.toggle()
      //  WeatherApp.shared.reloadDelegates()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
