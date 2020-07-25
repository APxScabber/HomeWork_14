//
//  FiveDaysWeatherRealmOptions.swift
//  HomeWork_14
//
//  Created by Alexey Peshekhonov on 22.07.2020.
//  Copyright © 2020 Alexey Peshekhonov. All rights reserved.
//

import Foundation
import RealmSwift

class FiveDaysWeatherRealmOptions: Object {
    
    @objc dynamic var dateMonth: String?
    @objc dynamic var dateDay: String?
    @objc dynamic var icon: String?
    @objc dynamic var temperature: String?
    
    convenience init(dateMonth: String, dateDay: String, icon: String, temperature: String) {
        self.init()
        self.dateMonth = dateMonth
        self.dateDay = dateDay
        self.icon = icon
        self.temperature = temperature
    }
}
