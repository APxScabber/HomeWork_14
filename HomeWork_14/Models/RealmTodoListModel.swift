//
//  RealmTodoListModel.swift
//  HomeWork_14
//
//  Created by Alexey Peshekhonov on 17.07.2020.
//  Copyright © 2020 Alexey Peshekhonov. All rights reserved.
//

import Foundation
import RealmSwift

class RealmTodoListModel: Object {
    
    @objc dynamic var task: String?
    
    convenience init(task: String) {
        self.init()
        self.task = task
    }
}
