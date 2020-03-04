//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    
  

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        
    
    }
    
    
    
    
    
    // when user click on return on search
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // closed keyboard
        searchTextField.endEditing(true)        
        return true
    }
    
    // when user submit text on textField
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       
            print(searchTextField.text!)
        
 
        
        return true
    }
    
    // when user click on search btn
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let userInputCity = searchTextField.text {
            weatherManager.fatchWeather(city: userInputCity)
        }
    }


}
    
