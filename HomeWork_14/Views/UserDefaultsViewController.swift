//
//  UserDefaultsViewController.swift
//  HomeWork_14
//
//  Created by Alexey Peshekhonov on 16.07.2020.
//  Copyright © 2020 Alexey Peshekhonov. All rights reserved.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FullNameModel.shared.nameUser != nil {
            nameTextField.text = FullNameModel.shared.nameUser!
        }
        
        if FullNameModel.shared.surnameUser != nil {
            surnameTextField.text = FullNameModel.shared.surnameUser!
        }
        
    }
    
//MARK: -Actions
    
    @IBAction func nameTExtFieldAction(_ sender: UITextField) {
        FullNameModel.shared.nameUser = sender.text
    }
    
    @IBAction func surnameTextFieldAction(_ sender: UITextField) {
        FullNameModel.shared.surnameUser = sender.text
    }
    

}
