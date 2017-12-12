//
//  TimeModel.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation


class TimeModel{
 
    var timeZoneId: String?
    var rawOffset: Int?
    var timeZoneName: String?
    
    init() {
        
    }
 
    init?(data: Data){
  
        do{
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: Any]
         
            if let timeZoneId = json["timeZoneId"] as? String{
                self.timeZoneId = timeZoneId
            }
            
            if let rawOffSet = json["rawOffset"] as? Int{
                self.rawOffset = rawOffSet
            }
            
        }catch{
            
        }
    }
    
}
