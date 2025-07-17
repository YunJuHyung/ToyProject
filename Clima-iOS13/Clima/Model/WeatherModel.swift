//
//  WeatherModel.swift
//  Clima
//
//  Created by 윤주형 on 4/20/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    //온도의 결과를 프린트하되 double -> String 소숫점 한자리 아래까지만 출력
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...233:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
}
