//
//  Date.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/10/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

class DateHelper{
	
	static func getLocalTime(dt: TimeInterval, timeZoneId: String) -> String{
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
        dateFormatter.timeZone = TimeZone(identifier: timeZoneId)
        
        return dateFormatter.string(from: date as Date)

    }
    
    static func getLocalData(dt: TimeInterval, timeZoneId: String) -> String{
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium//Set date style
        dateFormatter.timeZone = TimeZone(identifier: timeZoneId)
        return dateFormatter.string(from: date as Date)
        
    }
    
    static func isTomorrow(dt: TimeInterval ) -> Bool{
        return numberFromToday(dt: dt) == 1
    }
    
    static func numberFromToday(dt: TimeInterval) -> Int?{
        let todayDate = Date()
        
        let aDate = Date(timeIntervalSince1970: TimeInterval(1510664345000/1000))
        
        let calendar = NSCalendar.current
        
        let date1 = calendar.startOfDay(for: todayDate)
        let date2 = calendar.startOfDay(for: aDate)
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return (components.day)
    }
    
}