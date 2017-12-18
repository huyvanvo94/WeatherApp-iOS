//
//  Extensions.swift
//  WeatherApp
//
//  Created by Huy Vo on 12/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation
import UIKit

extension Date{
    
    static var timer: Int{
        return 60 - Date.currentSecond
    }
    
    static var currentSecond: Int{
        return Calendar.current.component(.second, from: Date())
    }
}

extension UIViewController{
   
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func displayAnimateSuccess(){
        
        // toast presented with multiple options and with a completion closure
        let w = UIScreen.main.bounds.width
        let h = UIScreen.main.bounds.height
        
        
        // let center = CGPoint(x: w/2, y: h/2)
        
        let image = UIImage(named: "success.png")
        let imageView = UIImageView(image: image)
        
        imageView.frame.origin.x = w/2 - 10
        imageView.frame.origin.y = h/2
        imageView.contentMode = .scaleAspectFit
        imageView.isHidden = false
        view.addSubview(imageView)
        
        UIView.animate(withDuration: 0.5, delay: 1.0, options: [], animations: {
            imageView.alpha = 0.0
        }) { (finished: Bool) in
            imageView.removeFromSuperview()
        }
    }
    
    
    
    
  
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

extension String{
    static func toTemperature(value: String) -> String{
        if currentTempUnit == .c{
            
            return "\(value)\u{00B0} C"
        }else{
            return "\(value)\u{00B0} F"
        }
        
    }
    
    
}

extension Double{
    static func toCelsius(value: Double) -> Double{
        return (value - 32.0)/(1.8)
    }
    
}

enum Temperature{
    case f
    case c
    
    
    mutating func toggle(){
        
        switch self {
        case .f:
            self = .c
    
        default:
            self = .f
        }
    }
}
