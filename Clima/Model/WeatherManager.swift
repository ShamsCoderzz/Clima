//
//  WeatherManager.swift
//  Clima
//
//  Created by Muhammad Shams on 04/03/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol WeatherDelegate {
    func updateUIforWeather(with weather : WeatherModel)
    func didFailWithError(error: String)

}

struct WeatherManager {
   
    
    let  baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=87e197e166cdd7936b6ec4a90d92eacc"
    
    var delegate : WeatherDelegate?
    
    func fetchWeather(city : String)  {
        let  requestURL = "\(baseUrl)&q=\(city)"
        print(requestURL)
        performRequest(urlString: requestURL)
        
    }
    
    
    
    func performRequest(urlString : String){
        // create URL
        let url = URL(string: urlString)
        // create season
        let session = URLSession(configuration: .default)
        // give the season to task
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil || data == nil {
                self.delegate?.didFailWithError(error: error.debugDescription)
                       return
                   }
            
            let http = response as? HTTPURLResponse
            print("\(http!.statusCode)")
                
            guard let httpsResponse = response as? HTTPURLResponse, (200...299).contains(httpsResponse.statusCode) else {
                let errorHandling = self.parseErrorJSON(error: data!)
                self.delegate?.didFailWithError(error: errorHandling!.message!)
                return
            }
            
            if  let weather = self.parseJSON(weather : data!){
                self.delegate?.updateUIforWeather(with: weather)
            }
                        
            //  let dataString = String(data: safeData, encoding: .utf8)
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: [])
//                print(json)
//            } catch {
//                print("JSON error: \(error.localizedDescription)")
            //}
                    
                   
        }
        // start the task
        task.resume()
    }
    
    
    func parseJSON(weather : Data) -> WeatherModel? {
        do {
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: weather)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weatherModel
        }catch {
            delegate?.didFailWithError(error: error.localizedDescription)
            return nil
        }
    }
    
    
    func parseErrorJSON(error : Data) -> ErrorHandling? {
        do{
        let decodedData = try JSONDecoder().decode(ErrorHandling.self, from: error)
            return decodedData
            }catch {
                delegate?.didFailWithError(error: error.localizedDescription)
                return nil
            }
    }
    
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(baseUrl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    

}


