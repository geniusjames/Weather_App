//
//  ViewModel.swift
//  WeatherApp
//
//  Created by Geniusjames on 21/11/2021.
//

import Foundation
import UIKit

var currentWeatherData: CurrentWeather?
struct CurrentWeatherViewModel{
    var backgroundColor: UIColor
    var backgroundImage: UIImage
    var minTemp: String
    var maxTemp: String
    var currentTemp: String
    var weatherDescription: String
    var weatherType: String
    init(with model: CurrentWeather){
        minTemp = String(Int(model.main.temp_min)) + "°"
        maxTemp = String(Int(model.main.temp_max)) + "°"
        currentTemp = String(Int(model.main.temp)) + "°"
        weatherDescription = (model.weather?[0].main)!
        
        
        if weatherDescription == "Clear"{
            weatherType = "SUNNY"
            backgroundImage = UIImage(imageLiteralResourceName: "sea_sunnypng")
            backgroundColor = UIColor(red: 71/225, green: 171/225, blue: 47/225, alpha: 1)
        }
        else if weatherDescription == "Clouds"{
            weatherType = "CLOUDY"
            backgroundImage = UIImage(imageLiteralResourceName: "sea_cloudy")
            backgroundColor = UIColor(red: 84/225, green: 113/225, blue: 112/225, alpha: 1)
        }
        else{
            weatherType = "RAINY"
            backgroundImage = UIImage(imageLiteralResourceName: "sea_rainy")
            backgroundColor = UIColor(red: 87/225, green:87/225, blue: 93/225, alpha: 1)
        }
    }
    
}

struct WeatherForecastViewModel{
    var cellDisplayImage: UIImage
    var days: String
    var temp: String
    var weatherType: String
    init(with model: List){
        temp = String(Int(model.main.temp)) + "°"
        print(index)
        weatherType = model.weather.description
        
        if weatherType == "Clear"{
            cellDisplayImage = UIImage(imageLiteralResourceName: "clear")
            
        }
        else if weatherType == "Clouds"{
            cellDisplayImage = UIImage(imageLiteralResourceName: "partlysunny")
        }
        else {
            cellDisplayImage = UIImage(imageLiteralResourceName: "rain")
        }
        
        let valDate = model.dt_txt
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let d = valDate
        let date = dateFormatter.date(from: d) ?? Date.now
        let dayOfWeek = Calendar.current.component(.weekday, from: date)
        let day = Calendar.current.weekdaySymbols[dayOfWeek - 1]
        days = day
    }
}


class ControllerViewModel{
    var currentWeatherVM: CurrentWeatherViewModel?
    var weatherForecastVM: [WeatherForecastViewModel]?
    var netWorkRequest = NetworkRequest()
    var weatherData: (() -> Void)?
    var forecastData: (() -> Void)?
    
    func populateCurrentWeatherView(){
        netWorkRequest.fetch(){ [weak self] currentWeatherData in
            
            DispatchQueue.main.async {
                self?.currentWeatherVM = CurrentWeatherViewModel(with: currentWeatherData)
              
                self?.weatherData?()
                
            }
        }
        
        
    }
    
    func populateWeatherForecastView(){
        
        netWorkRequest.fetchForecastData(){ [weak self] forecastData in
            DispatchQueue.main.async {
                self?.weatherForecastVM = []
                for weather in forecastData.list {
                    let weatherForecat = WeatherForecastViewModel(with: weather)
                    self?.weatherForecastVM?.append(weatherForecat)
                }
                self?.forecastData?()
                
            }
            
            
            
        }
    }
    
}

class NetworkRequest {
    
    var currentWeather: CurrentWeather?
    
    func fetch(completionHandler: @escaping (CurrentWeather)-> Void){
        
        let currentWeatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=lagos&appid=9477593aa7652cc46df3495f4e2945af&units=metric")
        URLSession.shared.request(url: currentWeatherURL, expecting: CurrentWeather.self){
            result in
            switch result{
            case .success(let weather):
                
                completionHandler(weather)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchForecastData(completiionHandler: @escaping (WeatherForecastData) -> Void){
        let weatherForecastURL = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=lagos&appid=9477593aa7652cc46df3495f4e2945af&units=metric")
        URLSession.shared.request(url: weatherForecastURL, expecting: WeatherForecastData.self){
            result in
            switch result{
            case .success(let weather):
                completiionHandler(weather)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
