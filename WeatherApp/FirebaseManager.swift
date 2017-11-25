//
//  FirebaseManager.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/12/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class FirebaseManager{

    var ref: DatabaseReference!
    
    init(){
        ref = Database.database().reference()
        
        
        
    }
    
    func add(todayWeather weatherModel: WeatherModel){
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(weatherModel)
        self.ref.child("weather").child("12313").setValue(String(data: data, encoding: .utf8)!)
    }
    // MARK - test
    func fetch(latlon: LatLon?, completion: ((WeatherModel)->() )?){
         
        ref.child("weather").child("12313").observeSingleEvent(of: .value, with: { (data) in
          
            if let json = data.value as? String{
                let jsonData = json.data(using: .utf8)!
                let decoder = JSONDecoder()
                let weatherModel = try! decoder.decode(WeatherModel.self, from: jsonData)
                if let completion = completion{
                    completion(weatherModel)
                }
            }
           
        })
        
        
    }
    
    func addUserToDB(user: User) -> String{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(user)
        
        let newRef = self.ref.child("users").childByAutoId()
        newRef.setValue(String(data: data, encoding: .utf8)!)
        
        return newRef.key
    }
    
    
    func addToDb(){
        let user = User(first: "Huy", last: "Vo")
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(user)
        
        let newRef = self.ref.child("users").childByAutoId()
        newRef.setValue(String(data: data, encoding: .utf8)!)
        
        let id = newRef.key
        
        print(id)
        
    }
}
