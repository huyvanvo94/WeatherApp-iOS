//
//  User.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/12/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation

class User: Codable{
    
    var id: String?
    
    let firstName: String
    let lastName: String
    
    init(first firstName: String, last lastName: String ){
        self.firstName = firstName
        self.lastName = lastName
    }
}

class PatronUser: User{
    
}

class AdminUser: User{
    
}

