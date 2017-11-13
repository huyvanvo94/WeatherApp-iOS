//
//  Service.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/8/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

class Event{
    
    
}

protocol ProcessEvent {
    func async_run()
}
// A ViewController needs to implement this
protocol ProcessDelegate {
    func error(_ event: Event)
    func complete(_ event: Event)
    
}
 
