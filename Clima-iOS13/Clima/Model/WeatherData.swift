//
//  WeatherData.swift
//  Clima
//
//  Created by 윤주형 on 4/20/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
