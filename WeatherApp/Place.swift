//
//  Place.swift
//  WeatherApp
//
//  Created by Huy Vo on 12/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

struct Place: Equatable, Hashable{
    // hash protocol
    var hashValue: Int{
        return self.city.hashValue ^ self.latitude.hashValue ^ self.longitude.hashValue &* 16777619
    }
    static func ==(lhs: Place, rhs: Place) -> Bool {
        
        return lhs.city == rhs.city
    }
    
    
    let city: String
    let longitude: Double
    let latitude: Double
    
    init(city: String, longitude: Double, latitude: Double) {
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
    }
    
    var googleLocation: String{
        get{
            return "\(self.latitude),\(self.longitude)"
        }
    }
    
    var openWeatherLocation: String{
        get{
            return "lat=\(self.latitude)&lon=\(self.longitude)"
        }
    }
 
}

extension Array {
    func doContains<T>(obj: T) -> Bool where T : Equatable {
        return self.filter({$0 as? T == obj}).count > 0
    }
}


