//
//  FullNameModel.swift
//  HomeWork_14
//
//  Created by Alexey Peshekhonov on 16.07.2020.
//  Copyright © 2020 Alexey Peshekhonov. All rights reserved.
//

import Foundation

class FullNameModel {
    
    static let shared = FullNameModel()
    
    private let kNameUserKey = "FullNameModel.kNameUserKey"
    private let kSurnameUserKey = "FullNameModel.kSurnameUserKey"
    
    var nameUser: String? {
        set { UserDefaults.standard.set(newValue, forKey: kNameUserKey) }
        get { return UserDefaults.standard.string(forKey: kNameUserKey) }
    }
    
    var surnameUser: String? {
        set { UserDefaults.standard.set(newValue, forKey: kSurnameUserKey) }
        get { return UserDefaults.standard.string(forKey: kSurnameUserKey) }
    }
}
