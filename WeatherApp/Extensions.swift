//
//  Extensions.swift
//  WeatherApp
//
//  Created by Huy Vo on 12/11/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
   
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
  
}
