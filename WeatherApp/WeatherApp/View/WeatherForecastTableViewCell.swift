//
//  WeatherForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Geniusjames on 21/11/2021.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var daysLabel: UILabel!
    
    @IBOutlet weak var tempImage: UIImageView!
    
    @IBOutlet weak var forecastTemperature: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func configure(with viewModel: WeatherForecastViewModel){
        daysLabel.text = viewModel.days
        forecastTemperature.text = String(viewModel.temp)
    }
    
}
