//
//  ViewController.swift
//  WeatherApp
//
//  Created by Geniusjames on 20/11/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var weatherTableView: UITableView!
    var vm = ControllerViewModel()
    var weatherForecastTableViewCell = WeatherForecastTableViewCell()
    @IBOutlet weak var tempLargeLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var weatherConditionImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherTableView.reloadData()
        vm.weatherData = updateCurrentWeatherViews
        vm.forecastData = updateForecastData
        
        vm.populateCurrentWeatherView()
        vm.populateWeatherForecastView()
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func updateCurrentWeatherViews() {
        self.weatherTableView.backgroundColor = self.vm.currentWeatherVM?.backgroundColor
        self.stackView.backgroundColor = self.vm.currentWeatherVM?.backgroundColor
        self.weatherTypeLabel.text = self.vm.currentWeatherVM?.weatherDescription
        self.minTemperatureLabel.text = self.vm.currentWeatherVM?.minTemp
        self.tempLargeLabel.text = self.vm.currentWeatherVM!.currentTemp
        self.currentTempLabel.text = self.vm.currentWeatherVM?.currentTemp
        self.maxTemperatureLabel.text = self.vm.currentWeatherVM?.maxTemp
        self.weatherConditionImage.image = self.vm.currentWeatherVM?.backgroundImage
        
    }
    
    func updateForecastData(){
        weatherTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WeatherForecastTableViewCell
        cell?.backgroundColor = self.vm.currentWeatherVM?.backgroundColor
        let data = vm.weatherForecastVM?[indexPath.row * 8 + 7]
        cell?.daysLabel.text = data?.days
        cell?.forecastTemperature.text = data?.temp
        cell?.tempImage.image = data?.cellDisplayImage
        
        
        return cell!
    }
    
}

