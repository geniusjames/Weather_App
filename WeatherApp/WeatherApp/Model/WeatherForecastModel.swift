//
//  WeatherForecastModel.swift
//  WeatherApp
//
//  Created by Geniusjames on 21/11/2021.
//

import Foundation

struct WeatherForecastData: Codable{
    let list: [List]
}
struct MainWeatherForecast: Codable{
    let temp : Float
}

struct WeatherForecast: Codable{
    
    let main: String
    let description: String
    let icon: String
}

struct List: Codable{
    let main: MainWeatherForecast
    let weather: [WeatherForecast]
    let dt_txt: String
}
