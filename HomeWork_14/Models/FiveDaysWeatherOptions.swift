//
//  FiveDaysWeatherOptions.swift
//  HomeWork_14
//
//  Created by Alexey Peshekhonov on 22.07.2020.
//  Copyright © 2020 Alexey Peshekhonov. All rights reserved.
//

import Foundation
import UIKit

class FiveDaysWeatherOptions {
    
    let options: [String]
    
    init?(data: NSDictionary) {
        guard
            let list = data["list"] as? NSArray,
            let options = createOptionsArray(data: list)
        else {
            return nil
        }
        self.options = options
    }
}

func createOptionsArray(data: NSArray) -> [String]? {
    
    let numbers = [4, 12, 20, 28, 36]
    var optionsArray = [String]()
    var temperatureArray = [String]()
    var dateArray = [String]()
    var iconArray = [String]()
    
    for number in numbers {
        let opt = data[number] as? NSDictionary
        let main = opt!["main"] as? NSDictionary
        let weather = opt!["weather"] as? NSArray
        let zero = weather![0] as? NSDictionary
        
        
        let tempK = main!["temp"] as? Double
        let tempC = Int(tempK! - 273.15)
        
        let date = opt!["dt"] as? Int
        
        let icon = zero!["icon"] as? String
  
        temperatureArray.append(String(tempC))
        dateArray.append(String(date!))
        iconArray.append(icon!)
        
    }
    optionsArray.append(contentsOf: temperatureArray)
    optionsArray.append(contentsOf: dateArray)
    optionsArray.append(contentsOf: iconArray)
    
    return optionsArray
}
