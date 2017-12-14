//
//  CityCell.swift
//  WeatherApp
//
//  Created by student on 12/14/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation
import UIKit

class CityCell: UITableViewCell{
    
    //MARK - Outlets
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var localTime: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var CityView: UIView!{
        didSet{
            configureView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configureView(){
        CityView.layer.shadowColor = UIColor.lightGray.cgColor
        CityView.layer.shadowOffset = CGSize(width: 0, height: 10)
        CityView.layer.shadowOpacity = 0.09
        CityView.layer.shadowRadius = 20
        CityView.layer.cornerRadius = 6
    }
}
