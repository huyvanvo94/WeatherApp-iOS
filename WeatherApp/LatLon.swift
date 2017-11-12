//
//  LatLon.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

protocol LocationFormat {
    var openWeatherLocation: String { get }
    
    var googleLocation: String { get  }
}

struct LatLon: LocationFormat{
  

    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
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

extension LatLon: Hashable{
    // hash protocol
    var hashValue: Int{
        return latitude.hashValue ^ longitude.hashValue &* 16777619
    }
    // Implement Equatable
    static func ==(lhs:LatLon, rhs:LatLon) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
