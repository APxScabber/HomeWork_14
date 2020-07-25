//
//  WeatherViewController.swift
//  HomeWork_14
//
//  Created by Alexey Peshekhonov on 22.07.2020.
//  Copyright © 2020 Alexey Peshekhonov. All rights reserved.
//

import UIKit
import SDWebImage
import RealmSwift

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
        @IBOutlet weak var dateLabel: UILabel!
        @IBOutlet weak var pictureImage: UIImageView!
        @IBOutlet weak var descriptionLabel: UILabel!
        @IBOutlet weak var temperatureLabel: UILabel!
        @IBOutlet weak var windLabel: UILabel!
        @IBOutlet weak var pressureLabel: UILabel!
        @IBOutlet weak var humidityLabel: UILabel!
        
        @IBOutlet weak var tableView: UITableView!

        var weatherOpt =  WeatherLoader()
        
        let realm = try! Realm()
        var weatherRealmOpt: Results<WeatherRealmOptions>!
        var weatherRealmDaysOpt: Results<FiveDaysWeatherRealmOptions>!
        
        var tempArray = [String]()
        var dateArray = [[String]]()
        var iconArray = [String]()
 
        override func viewDidLoad() {
            super.viewDidLoad()
            weatherOpt.delegate = self
            weatherOpt.loadWeatherAlamofire()
            weatherOpt.forecastLoadWeatherAlamofire()
            
            weatherRealmOpt = realm.objects(WeatherRealmOptions.self)
            weatherRealmDaysOpt = realm.objects(FiveDaysWeatherRealmOptions.self)
            
            realmCasheWeatherLoad()
        }
    
    //MARK: -Functions

    func realmCasheWeatherLoad() {
        
        if !weatherRealmOpt.isEmpty {
            
            let weather = weatherRealmOpt.first
            
            cityLabel.text = weather?.city
            dateLabel.text = weather?.date
            guard let url = URL(string: (weather?.icon)!) else { return }
            pictureImage.sd_setImage(with: url, placeholderImage: nil, options: [], completed: nil)
            descriptionLabel.text = weather?.weatherDescription
            temperatureLabel.text = weather?.temperature
            windLabel.text = weather?.windSpeed
            pressureLabel.text = weather?.pressure
            humidityLabel.text = weather?.humidity
            
        }
    }
}

//MARK: -Extensions
extension WeatherViewController: WeatherLoaderDelegate {

    func loaded(weatherOptions: WeatherOptions) {
        cityLabel.text = weatherOptions.city
        dateLabel.text = "\(weatherOptions.date[0].capitalized) | \(weatherOptions.date[1].capitalized)"
        guard let url = URL(string: weatherOptions.icon) else { return }
        pictureImage.sd_setImage(with: url, placeholderImage: nil, options: [], completed: nil)
        descriptionLabel.text = weatherOptions.weatherDescription
        temperatureLabel.text = "\(weatherOptions.temperature) ˚С"
        windLabel.text = "\(weatherOptions.windSpeed) м/с"
        pressureLabel.text = "\(weatherOptions.pressure) mm рт. ст."
        humidityLabel.text = "\(weatherOptions.humidity) %"
        
        let saveRealmDate = WeatherRealmOptions(city: weatherOptions.city, date: "\(weatherOptions.date[0].capitalized) | \(weatherOptions.date[1].capitalized)", icon: weatherOptions.icon, weatherDescription: weatherOptions.weatherDescription, temperature: "\(weatherOptions.temperature) ˚С", humidity: "\(weatherOptions.windSpeed) м/с", windSpeed: "\(weatherOptions.pressure) mm рт. ст.", pressure: "\(weatherOptions.humidity) %")
        
        if !weatherRealmOpt.isEmpty {
            try! realm.write {
                realm.delete(weatherRealmOpt)
            }
            
            try! realm.write {
                realm.add(saveRealmDate)
            }
        } else {
            try! realm.write {
                realm.add(saveRealmDate)
            }
        }
    }
        
    func daysLoaded(weatherOptions: FiveDaysWeatherOptions) {
            
        tempArray = [weatherOptions.options[0], weatherOptions.options[1], weatherOptions.options[2],
                    weatherOptions.options[3],weatherOptions.options[4]]

        for i in 5 ... 9 {
            let date = Int(weatherOptions.options[i])
            dateArray.append(dateConvert(currentDate: Double(date!))!)
        }
            
        for i in 10 ... 14 {
            iconArray.append(iconDownload(iconCode: weatherOptions.options[i])!)
        }
        
        if !weatherRealmDaysOpt.isEmpty {
            
            try! realm.write {
                realm.delete(weatherRealmDaysOpt)
            }
            
            for i in 0 ... 4 {
                let dateMonth = dateArray[i][1]
                let dateDay = dateArray[i][0]
                let temp = tempArray[i]
                let icon = iconArray[i]
                let saveDaysWeather = FiveDaysWeatherRealmOptions(dateMonth: dateMonth, dateDay: dateDay, icon: icon, temperature: temp)
                
                try! realm.write {
                    realm.add(saveDaysWeather)
                }
            }
        } else {
            for i in 0 ... 4 {
                let dateMonth = dateArray[i][1]
                let dateDay = dateArray[i][0]
                let temp = tempArray[i]
                let icon = iconArray[i]
                let saveDaysWeather = FiveDaysWeatherRealmOptions(dateMonth: dateMonth, dateDay: dateDay, icon: icon, temperature: temp)
                
                try! realm.write {
                    realm.add(saveDaysWeather)
                }
            }
        }
        
        tableView.reloadData()
        }
    }

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        if !dateArray.isEmpty {
            cell.monthLabel.text = dateArray[indexPath.row][1]
            cell.dayLabel.text = dateArray[indexPath.row][0]
            cell.temperatureLabel.text = tempArray[indexPath.row]
            guard let url = URL(string: iconArray[indexPath.row]) else { return cell }
            cell.pictureImageView.sd_setImage(with: url, completed: nil)
        } else {
            if !weatherRealmDaysOpt.isEmpty {
                let dayWeather = weatherRealmDaysOpt[indexPath.row]
                cell.monthLabel.text = dayWeather.dateMonth
                cell.dayLabel.text = dayWeather.dateDay
                cell.temperatureLabel.text = dayWeather.temperature
                guard let url = URL(string: dayWeather.icon!) else { return cell }
                cell.pictureImageView.sd_setImage(with: url, completed: nil)
            }
        }
        return cell
    }
}
