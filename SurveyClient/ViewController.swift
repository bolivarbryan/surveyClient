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
        // Do any additional setup after loading the view.
        Core().printTest()
        API().printTest()
        Style().printTest()
    }


}

