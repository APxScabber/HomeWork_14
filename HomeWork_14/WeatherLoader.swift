//
//  WeatherLoader.swift
//  HomeWork_14
//
//  Created by Alexey Peshekhonov on 22.07.2020.
//  Copyright © 2020 Alexey Peshekhonov. All rights reserved.
//

import Foundation
import Alamofire

protocol WeatherLoaderDelegate {
    func loaded (weatherOptions: WeatherOptions)
    func daysLoaded (weatherOptions: FiveDaysWeatherOptions)
}

class WeatherLoader {
    
    var delegate: WeatherLoaderDelegate?
    
    func loadWeatherAlamofire() {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=2730e6546155fce8760a5e6b14fa3c7e&lang=ru")!
        AF.request(url).responseJSON { response in
            if let objects = response.value,
                let jsonDict = objects as? NSDictionary {
                let allWeatherData = WeatherOptions(data: jsonDict)
                DispatchQueue.main.async {
                    self.delegate?.loaded(weatherOptions: allWeatherData!)
                }
            }
        }
    }
    
    func forecastLoadWeatherAlamofire() {
        let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Moscow&appid=2730e6546155fce8760a5e6b14fa3c7e")!
        AF.request(url).responseJSON { response in
            if let objects = response.value,
                let jsonDict = objects as? NSDictionary {
                let allWeatherData = FiveDaysWeatherOptions(data: jsonDict)
                DispatchQueue.main.async {
                    self.delegate?.daysLoaded(weatherOptions: allWeatherData!)
                }
            }
        }
    }
}
