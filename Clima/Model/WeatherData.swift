//
//  WeatherData.swift
//  Clima
//
//  Created by Muhammad Shams on 05/03/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Codable {
    
    let id : Int
    let name : String
    let timezone : Int
    let sys : Sys
    let main: Main
    let weather: [Weather]

}


struct Sys : Codable {
    let country : String
    let sunrise : Int
    let sunset : Int
}

struct Main : Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}


