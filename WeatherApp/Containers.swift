//
//  Containers.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

class Cities{

}


class LatLonContainer{
    private var locations = [LatLon]()
    
    static let shared = LatLonContainer()
    
    private init(){}
    
    
    func add(location latlon: LatLon!){
        
        locations.append(latlon)
        
    }
    
    func contains(location laton: LatLon) -> Bool{
        return locations.contains(where: {$0 == laton })
    }
    
}
