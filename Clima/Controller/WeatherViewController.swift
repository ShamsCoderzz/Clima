//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
   
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!

    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        locationManager.delegate = self
        weatherManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
       
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
//            if CLLocationManager.locationServicesEnabled() {
//                switch CLLocationManager.authorizationStatus() {
//                    case .notDetermined, .restricted, .denied:
//                        alertLocationPermission()
//                    case .authorizedAlways, .authorizedWhenInUse:
//                        print("Access")
//                    @unknown default:
//                    break
//                }
//                } else {
//                    alertLocationPermission()
//            }
    }
    
    
    func alertLocationPermission() {
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "Settings", style: .default, handler: { (cAlertAction) in
            //Redirect to Settings app
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel , handler: { (action) in
           // self.locationManager.requestLocation()
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        self.present(alertController, animated: true, completion: nil)
    }
    
}

//MARK: - UITextField
extension WeatherViewController : UITextFieldDelegate {
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
               weatherManager.fetchWeather(city: userInputCity)
           }
       }
}

//MARK: - delegate
extension WeatherViewController : WeatherDelegate {
    
    func updateUIforWeather(with weather: WeatherModel) {
          DispatchQueue.main.async { // Correct
               self.temperatureLabel.text = weather.temperatureString
               self.conditionImageView.image = UIImage(systemName: weather.conditionName)
               self.cityLabel.text = weather.cityName

          }
      }
      
      func didFailWithError(error: String) {
             print(error)
          
          DispatchQueue.main.async {
          
          let alert=UIAlertController(title: "Warning!!", message: error, preferredStyle: .alert)
              self.present(alert, animated: true, completion: nil)
                 
                 // add button
                 let cancelBtn=UIAlertAction(title: "Cancle", style: .cancel) { (action) in
                     print("cancel")
                 }
                 
                 alert.addAction(cancelBtn)
          }

      }
}

//MARK: - location
extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
                  locationManager.stopUpdatingLocation()
                  let lat = location.coordinate.latitude
                  let lon = location.coordinate.longitude
                  weatherManager.fetchWeather(latitude: lat, longitude: lon)
              }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}


    
