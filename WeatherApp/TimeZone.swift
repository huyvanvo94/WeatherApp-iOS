//
//  TimeZone.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/8/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation



class TimeZone: NSObject{
    var dstOffset: Int?
    var rawOffset: Int?
    
    var timeZoneId: String!
    
    
    init(timeZoneId: String) {
        self.timeZoneId = timeZoneId
        super.init()
        
    }
}
