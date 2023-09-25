//
//  ViewController.swift
//  SurveyClient
//
//  Created by Bryan A Bolivar M on 24/09/23.
//

import UIKit
import Core
import Style
import API

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIProvider.request(service: .register(email: "bryan+1@coderlabs.co",
                                                  name: "Bryan",
                                                  password: "12345678",
                                                  passwordConfirmation: "12345678")) { data in
            DispatchQueue.main.async {
                print(data)
            }
        }
    }
}
