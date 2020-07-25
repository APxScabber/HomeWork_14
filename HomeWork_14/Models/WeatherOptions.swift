//
//  WeatherOptions.swift
//  HomeWork_14
//
//  Created by Alexey Peshekhonov on 22.07.2020.
//  Copyright © 2020 Alexey Peshekhonov. All rights reserved.
//

import Foundation
import SwiftUI

class WeatherOptions {
    
    let city: String
    let date: [String]
    let icon: String
    let weatherDescription: String
    let temperature: Int
    let humidity: Int
    let windSpeed: Int
    let pressure: Int
    
    init?(data: NSDictionary) {
        guard
            let city = data["name"] as? String,
            let weather = data["weather"] as? NSArray,
            let zero = weather[0] as? NSDictionary,
            let weatherDescription = zero["description"] as? String,
            let main = data["main"] as? NSDictionary,
            let temperature = main["temp"] as? Double,
            let humidity = main["humidity"] as? Int,
            let pressure = main["pressure"] as? Int,
            let wind = data["wind"] as? NSDictionary,
            let windSpeed = wind["speed"] as? Int,
            let utcDate = data["dt"] as? Double,
            let date = dateConvert(currentDate: utcDate),
            let icon = iconDownload(iconCode: ((zero["icon"] as? String)!))
            
            else {
            return nil
        }
           
        self.city = city
        self.weatherDescription = weatherDescription
        self.temperature = tempConvert(tempK: temperature)
        self.humidity = humidity
        self.pressure = pressure
        self.windSpeed = windSpeed
        self.date = date
        self.icon = icon
    }
}

func tempConvert(tempK: Double) -> Int {
    return Int(tempK - 273.15)
}

func dateConvert(currentDate: Double) -> [String]? {
    var dateArray = [String]()
    let dayFormater = DateFormatter()
    let dateFormater = DateFormatter()
    
    dayFormater.locale = Locale.init(identifier: "ru_RU")
    dateFormater.locale = Locale.init(identifier: "ru_RU")
    dayFormater.dateFormat = "EEEE"
    dateFormater.dateFormat = "d MMMM"

    let fullDate = NSDate(timeIntervalSince1970: currentDate)
    let day = dayFormater.string(from: fullDate as Date)
    let date = dateFormater.string(from: fullDate as Date)
    dateArray.append(day)
    dateArray.append(date)
    return dateArray
}

func iconDownload(iconCode: String) -> String? {
    
    let url = "http://openweathermap.org/img/wn/\(iconCode)@2x.png"
    return  url
}
