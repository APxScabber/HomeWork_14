//
//  WeatherRealmOptions.swift
//  HomeWork_14
//
//  Created by Alexey Peshekhonov on 22.07.2020.
//  Copyright © 2020 Alexey Peshekhonov. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherRealmOptions: Object {
    
    @objc dynamic var city: String?
    @objc dynamic var date: String?
    @objc dynamic var icon: String?
    @objc dynamic var weatherDescription: String?
    @objc dynamic var temperature: String?
    @objc dynamic var humidity: String?
    @objc dynamic var windSpeed: String?
    @objc dynamic var pressure: String?
    
    convenience init(city: String, date: String, icon: String, weatherDescription: String, temperature: String, humidity: String, windSpeed: String, pressure: String) {
        self.init()
        self.city = city
        self.date = date
        self.icon = icon
        self.weatherDescription = weatherDescription
        self.temperature = temperature
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.pressure = pressure
    }
}
