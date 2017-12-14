//
//  TempLabel.swift
//  WeatherApp
//
//  Created by student on 12/14/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation
import UIKit

class TempLabel: UILabel{
    override func awakeFromNib() {
        self.clipsToBounds = true
        self.textColor = UIColor(rgb: 0x143468)
        self.font = UIFont(name: "Verdana", size: Screen.height * 0.04)
        self.textAlignment = .left
    }
    
    override func drawText(in rect: CGRect) {
        
        super.drawText(in: rect)
    }
    
    
}
