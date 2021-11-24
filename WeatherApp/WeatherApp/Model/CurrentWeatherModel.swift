//
//  CurrentWeatherModel.swift
//  WeatherApp
//
//  Created by Geniusjames on 20/11/2021.
//

import Foundation

struct CurrentWeather: Codable{
    let weather: [Weather]?
    let main: Main
    
    
}

struct Weather: Codable{
    let main: String
}

struct Main: Codable{
    let temp: Double
    let temp_min, temp_max: Double
}

