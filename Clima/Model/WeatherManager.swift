//
//  WeatherManager.swift
//  Clima
//
//  Created by Muhammad Shams on 04/03/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    init() {
    }
    
    let  baseUrl = "https://api.openweathermap.org/data/2.5/weather?appid=87e197e166cdd7936b6ec4a90d92eacc"
    
    
    func fatchWeather(city : String)  {
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
        
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                       print(error!.localizedDescription)
                       return
                   }
                   
                   if let safeData = data {
                       let dataString = String(data: safeData, encoding: .utf8)
                       print(dataString!)
                   }else {
                       print("nil")
                   }
                   
        }
        
        
        // start the task
        task.resume()
        
        
        
    }
   
    
    
}
